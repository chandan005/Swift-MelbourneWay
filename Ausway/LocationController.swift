//
//  LocationController.swift
//  Ausway
//
//  Created by Chandan Singh on 9/05/2016.
//  Copyright © 2016 RMIT. All rights reserved.
//
// Gets the Current location, let's user enter the destination address and other information to display the
// route

import UIKit
import CoreLocation
import MapKit

class LocationController: UIViewController, UITextFieldDelegate {
    
    //Mark: Properties
    
    @IBOutlet weak var currentField: UITextField!
    
    @IBOutlet weak var destinationField: UITextField!
    
    @IBOutlet var checkAddressButtons: [UIButton]!
    
    @IBOutlet weak var estimateFareButton: UIButton!
    
    @IBOutlet weak var numberOfPassengersField: UITextField!
    
    @IBOutlet weak var passengerStepper: UIStepper!
    
    @IBOutlet weak var viewRouteButton: UIButton!
    
    // Store value of number of passengers
    var numberOfPassengers: String!
    
    let locationManager = CLLocationManager()
    
    var locationTuples: [(textField: UITextField!, mapItem: MKMapItem?)]!
    
    // Stores travel Details
    var travelPlans: String!
    
    var locationsArray: [(textField: UITextField!, mapItem: MKMapItem?)] {
        var filtered = locationTuples.filter({ $0.mapItem != nil })
        filtered += [filtered.first!]
        return filtered
    }
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkAddressButtons.first?.layer.cornerRadius = 5
        checkAddressButtons.last?.layer.cornerRadius = 5
        estimateFareButton.layer.cornerRadius = 5
        viewRouteButton.layer.cornerRadius = 5
        
        
        // TextField Validation
        numberOfPassengersField.delegate = self
        currentField.delegate = self
        destinationField.delegate = self
        //numberOfPassengersField.keyboardType = UIKeyboardType.NumberPad
        
        
        locationTuples = [(currentField, nil), (destinationField, nil)]
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
            locationManager.requestLocation()
        }
        viewTravelDetils()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
    }
    
    
    //Mark: Actions
    
    // Address Entered
    @IBAction func checkAddressAction(sender: UIButton) {
        view.endEditing(true)
        
        let currentTextField = locationTuples[sender.tag-1].textField
        
        CLGeocoder().geocodeAddressString(currentTextField.text!,
                                          completionHandler: {(placemarks: [CLPlacemark]?, error: NSError?) -> Void in
                                            if let placemarks = placemarks {
                                                var addresses = [String]()
                                                for placemark in placemarks {
                                                    addresses.append(self.formatAddressFromPlacemark(placemark))
                                                }
                                                self.showAddressTable(addresses, textField: currentTextField,
                                                    placemarks: placemarks, sender: sender)
                                            } else {
                                                self.showAlert("Address not found.")
                                            }
        })
    }
    
    
    // View Map
    @IBAction func viewRoute(sender: AnyObject) {
        view.endEditing(true)
        if destinationField.text == "" {
            showAlert("Please enter the current and destination address")
        } else {
            performSegueWithIdentifier("viewmap", sender: self)
        }
        
    }
    
    // Estimate Fare
    @IBAction func estimateFare(sender: AnyObject) {
        view.endEditing(true)
        performSegueWithIdentifier("estimatefare", sender: self)
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        if (locationTuples[0].mapItem == nil) || (locationTuples[1].mapItem == nil) {
            showAlert("Please enter a valid starting point and destination.")
            return false
        } else {
            return true
        }
    }
    // Prepare for Segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "viewmap") {
            let routeViewController = segue.destinationViewController as! RouteViewController
            routeViewController.locationArray = locationsArray
        }
        
        if (segue.identifier == "estimatefare"){
            let fareCalculator = segue.destinationViewController as! EstimateFareController
            fareCalculator.traveller = " The taxi fare from \(currentField.text) to \(destinationField.text) is estimated at AUD \(95)"
        }
    }
    
    // Alerts if, correct address not entered
    func showAlert(alertString: String) {
        let alert = UIAlertController(title: nil, message: alertString, preferredStyle: .Alert)
        let okButton = UIAlertAction(title: "OK",
                                     style: .Cancel) { (alert) -> Void in
        }
        alert.addAction(okButton)
        presentViewController(alert, animated: true, completion: nil)
    }
    
    // Format the address entered
    func formatAddressFromPlacemark(placemark: CLPlacemark) -> String {
        return (placemark.addressDictionary!["FormattedAddressLines"] as!
            [String]).joinWithSeparator(", ")
    }
    
    // Displasy possible destination address in a table
    func showAddressTable(addresses: [String], textField: UITextField,
                          placemarks: [CLPlacemark], sender: UIButton) {
        
        let addressTableView = DestinationTableView(frame: UIScreen.mainScreen().bounds, style: UITableViewStyle.Plain)
        addressTableView.addresses = addresses
        addressTableView.currentTextField = textField
        addressTableView.placemarkArray = placemarks
        addressTableView.mainViewController = self
        addressTableView.sender = sender
        addressTableView.delegate = addressTableView
        addressTableView.dataSource = addressTableView
        view.addSubview(addressTableView)
    }
    
 
    
    // Action
    // Stepper Value Changed
    
    @IBAction func stepperValueChanged(sender: UIStepper) {
        numberOfPassengersField.text = Int(sender.value).description
        self.numberOfPassengers = numberOfPassengersField.text
    }
    
    // Tapped Background Action
    
    @IBAction func tappedBackground(sender: AnyObject) {
        view.endEditing(true)
    }
    
    // function textfield Number of passengers
    
    func textFieldNumberofPassengers(textField: UITextField, range: NSRange, string: String) {
        
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if textField.tag == 1 || textField.tag == 2 {
            checkAddressButtons.filter{$0.tag == textField.tag}.first!.selected = false
            locationTuples[textField.tag-1].mapItem = nil
            
        }
        return true
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        
        if textField.tag == 3 {
            textField.keyboardType = UIKeyboardType.NumberPad
        }

    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        
        if textField.tag == 3 {
            if textField.text != "1" || textField.text != "2" || textField.text != "3" || textField.text != "4" || textField.text != "5" || textField.text != "6" || textField.text != "7" || textField.text != "8" || textField.text != "9" || textField.text != "10" {
                showAlert("Taxis in melbourne have a limit of maximum 10 passengers.")
            } else {
                self.numberOfPassengers = textField.text
            }
        }
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
    
    
    // Travel Details
    
    func viewTravelDetils() {
        self.travelPlans = "\(self.currentField.text) to \(self.destinationField.text) is estimated at \(200)"
    }
    
    
}


// Extension to get all the location information and store in the text fields
extension LocationController: CLLocationManagerDelegate {
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        CLGeocoder().reverseGeocodeLocation(locations.last!,
                                            completionHandler: {(placemarks:[CLPlacemark]?, error:NSError?) -> Void in
                                                if let placemarks = placemarks {
                                                    let placemark = placemarks[0]
                                                    self.locationTuples[0].mapItem = MKMapItem(placemark:
                                                        MKPlacemark(coordinate: placemark.location!.coordinate,
                                                            addressDictionary: placemark.addressDictionary as! [String:AnyObject]?))
                                                    self.currentField.text = self.formatAddressFromPlacemark(placemark)
                                                    
                                                    self.checkAddressButtons.filter{$0.tag == 1}.first!.selected = true
                                                    
                                                }
        })
        
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print(error)
    }
}

