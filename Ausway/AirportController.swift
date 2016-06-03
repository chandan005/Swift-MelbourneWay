//
//  ViewController.swift
//  Ausway
//
//  Created by Chandan Singh on 15/04/2016.
//  Copyright © 2016 RMIT. All rights reserved.
//
// View Controlelr displaying the landing page of the application, it also conforms to the PopOverController
//delegate to get tha data for which buttons were clicked in the popover page.

import UIKit
import Foundation


class AirportController: UIViewController, UIPopoverPresentationControllerDelegate, PopOverControllerDelegate {
    
    // Mark: Properties
    
    @IBOutlet var passengerButtons: [UIButton]!
    
    var senders = UIButton()
    
    var senderData: Int!
    
    var skybust1: [SkybusT1]!
    
    @IBOutlet weak var weatherContainer: UIView!
    
    @IBOutlet weak var chartContainer: UIView!
    
    let tapRecChart = UITapGestureRecognizer()
    
    let tapRecWeather = UITapGestureRecognizer()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "MW"
        
        self.navigationController!.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "Futura", size: 20)!]
        
        // Set the color of navigation bar
        navigationController?.navigationBar.barTintColor = UIColor(red: 23.0/255.0, green: 1.0/255.0, blue: 23.0/255.0, alpha: 1.0)
        
        //Set the text color of the navigation bar title
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        // Set the color of other items of navigation bar
        navigationController?.navigationBar.tintColor = UIColor.whiteColor()

        //Set the corner radius of the buttons
        passengerButtons[0].layer.cornerRadius = 8
        passengerButtons[1].layer.cornerRadius = 8
        passengerButtons[2].layer.cornerRadius = 8
        
        
        tapRecChart.addTarget(self, action: #selector(AirportController.chartTapped))
        chartContainer.addGestureRecognizer(tapRecChart)
        
        tapRecWeather.addTarget(self, action: #selector(AirportController.weatherTapped))
        weatherContainer.addGestureRecognizer(tapRecWeather)
        
    }
    
    // When Chart section tapped perform segue
    func chartTapped() {
        performSegueWithIdentifier("showChart", sender: self)
    }
    
    // When Weather Section tapped perform segue
    func weatherTapped() {
        performSegueWithIdentifier("showWeather", sender: self)
    }
    override func viewWillAppear(animated: Bool) {
        navigationController?.navigationBarHidden = false
    }
    
    
    // Show Popover Controller when button clicked
    @IBAction func justArrivedAction(sender: AnyObject) {
        self.senders.tag = 1
        getPopOver(sender)
       
    }

     // Show Popover Controller when button clicked
    @IBAction func gettingLuggageAction(sender: AnyObject) {
        self.senders.tag = 2
        getPopOver(sender)
        
    }

     // Show Popover Controller when button clicked
    @IBAction func readyToGoAction(sender: AnyObject) {
        self.senders.tag = 3
        getPopOver(sender)
        
    }
    
    
    
    // Displays Popover when buttons clicked
    func getPopOver(sender: AnyObject) {
        let VC = storyboard?.instantiateViewControllerWithIdentifier("PopOverController") as! PopOverController
        VC.delegate = self
        VC.senders = senders
        VC.preferredContentSize = CGSize(width: UIScreen.mainScreen().bounds.width, height: 200)
        
        VC.modalPresentationStyle = UIModalPresentationStyle.Popover
        
        let popOver = VC.popoverPresentationController
        popOver?.permittedArrowDirections = .Any
        popOver?.delegate = self
        popOver?.sourceView = sender as? UIView
        popOver?.sourceRect = sender.bounds!
        
        self.presentViewController(VC, animated: true, completion: nil)
    }
    
    // Presentation Style for the Popover
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return .None
    }
    

    // Implements the delegate method from the PopOverController
    func sendTimeTable(array1: [SkybusT1]!) {
        self.skybust1 = array1
        self.dismissViewControllerAnimated(true, completion: nil)
        performSegueWithIdentifier("toTabBar", sender: self)
        
    }
    
    // Checks for the segue identifier to perform the segue to TimeTableController
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "toTabBar" {
            let tabBarController = segue.destinationViewController as! UITabBarController
            let nextFiveController = tabBarController.viewControllers?.first as! TimeTableViewController
            nextFiveController.skybust1 = skybust1
        }        
        
    }
    
    // Displays the Weather and Chart Sections 
    func getWeatherAndChart() {
        let CC = storyboard?.instantiateViewControllerWithIdentifier("aa") as! FeedsChartController
        CC.preferredContentSize = CGSize(width: 250, height: 250)
        
        self.addChildViewController(CC)
        self.view.addSubview(CC.view)
    }
    
    
}



