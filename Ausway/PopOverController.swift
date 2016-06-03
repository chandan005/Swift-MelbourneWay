//
//  PopOverController.swift
//  Ausway
//
//  Created by Chandan Singh on 15/04/2016.
//  Copyright © 2016 RMIT. All rights reserved.
//
// View Controller to display the PopOver
import UIKit
import SwiftyJSON

// Protocol
protocol PopOverControllerDelegate {
    func sendTimeTable(array: [SkybusT1]!)
}

class PopOverController: UIViewController {
    
    // Mark: Properties
    
    var delegate: PopOverControllerDelegate?
    
    // Gets the tag id for the "Done Button"
    var senderTag: Int?
    
    var senders: UIButton!
    
    var skybust1: [SkybusT1]!

    // Outlet for done button
    @IBOutlet weak var done: UIButton!
    
    // Outlet for terminal segment buttons
    @IBOutlet weak var t1t2t3: UISegmentedControl!
    
    // Outlet for Passenger Type Button
    @IBOutlet weak var passengerType: UISegmentedControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        senderTag = done.tag
        
        self.title = "Preferences"
        
        done.layer.cornerRadius = 8
        
        skybust1 = [SkybusT1]()
    
        //addSkybusT1Data()
    }
    

    
    //Mark: Actions
    
    // Show data based on the selected segment
    @IBAction func terminalChanged(sender: UISegmentedControl) {
            }
    
    
    
    @IBAction func doneAction(sender: AnyObject) {
        
        
        switch t1t2t3.selectedSegmentIndex {
            // If Terminal 1 Selected
        case 0:
            addSkybusT1Data()
            switch self.senders.tag {
            case 1:
                // If "Just Arrived" Selected
                self.skybust1.removeFirst(10)
                
            case 2:
                // If "Getting the Luggage" Selected
                self.skybust1.removeFirst(5)
                
            case 3:
                // If "Ready To Go" Selected
                self.skybust1.removeFirst(2)
                
            default:
                break
            }
            
            // Delegate the method with Skybus T1 Timetable to Airport Controller
            delegate?.sendTimeTable(self.skybust1)
            
        case 1:
            // If Terminal 3 selected
            addSkybusT3Data()
            switch self.senders.tag {
            case 1:
                // If "Just Arrived Selected"
                self.skybust1.removeFirst(10)
                
            case 2:
                // If "Getting the Luggage" Selected
                self.skybust1.removeFirst(5)
                
            case 3:
                // If "Ready To Go" Selected
                self.skybust1.removeFirst(2)
                
            default:
                break
            }
            
            // Delegate the method with Skybus T3 Timetable to Airport Controller
            delegate?.sendTimeTable(self.skybust1)
            
        case 2:
            // If Terminal 4 Selected
            addSkybusT4Data()
            switch self.senders.tag {
            case 1:
                // If "Just Arrived Selected"
                self.skybust1.removeFirst(10)
                
            case 2:
                // If "Getting the Luggage" Selected
                self.skybust1.removeFirst(5)
                
            case 3:
                // If "Ready To Go" Selected
                self.skybust1.removeFirst(2)
                
            default:
                break
            }
           
            // Delegate the method with Skybus T4 Timetable to Airport Controller
            delegate?.sendTimeTable(self.skybust1)
            
        default:
            break
        }

    }
    
    
    
    // Stores the data for passenger type
    @IBAction func passengerSelected(sender: UISegmentedControl? = nil) {
        switch passengerType.selectedSegmentIndex {
        case 0:
            // If Domestic button tapped
            postDomesticData()
            
            
        case 1:
            // If International button tapped
            postInternationalData()
            
        default:
            break
        }
    }
    
    // Gets the data from Web API and stores in the Skybus Struct
    func addSkybusT1Data() {
        RestAPIManager.sharedInstance.url = "http://www.melbournecloudstudio.com/skybus_t1s/timeQueries"
        RestAPIManager.sharedInstance.getRandomItem { (json: JSON) in
            
            for n in json {
                let ids = n.1["id"].intValue
                let time = n.1["timetable"].stringValue
                let timeIn = NSDate().timeInterval(time)
                let newSkybus = SkybusT1(id: ids, timetable: time, leftTime: timeIn)
                self.skybust1.append(newSkybus)
            }
            dispatch_async(dispatch_get_main_queue(),{
                
            })
            
        }
    }
    
    // Gets the data from Web API and stores in the Skybus Struct
    func addSkybusT3Data() {
        RestAPIManager.sharedInstance.url = "http://www.melbournecloudstudio.com/skybus_t3s/timeQueries"
        RestAPIManager.sharedInstance.getRandomItem { (json: JSON) in
            
            for n in json {
                let ids = n.1["id"].intValue
                let time = n.1["timetable"].stringValue
                let timeIn = NSDate().timeInterval(time)
                let newSkybus = SkybusT1(id: ids, timetable: time, leftTime: timeIn)
                self.skybust1.append(newSkybus)
            }
            dispatch_async(dispatch_get_main_queue(),{
                
            })
            
        }
    }
    // Gets the data from Web API and stores in the Skybus Struct
    func addSkybusT4Data() {
        RestAPIManager.sharedInstance.url = "http://www.melbournecloudstudio.com/skybus_t4s/timeQueries"
        RestAPIManager.sharedInstance.getRandomItem { (json: JSON) in
            
            for n in json {
                let ids = n.1["id"].intValue
                let time = n.1["timetable"].stringValue
                let timeIn = NSDate().timeInterval(time)
                let newSkybus = SkybusT1(id: ids, timetable: time, leftTime: timeIn)
                self.skybust1.append(newSkybus)
            }
            dispatch_async(dispatch_get_main_queue(),{
                
            })
            
        }
    }
    
    // Posts the Domestic Data to Web API
    func postDomesticData(){
        let postEndpoint: String = "http://www.melbournecloudstudio.com/domestics"
        let url = NSURL(string: postEndpoint)!
        let session = NSURLSession.sharedSession()
        let postParams : [String: AnyObject] = ["tapped_timestamp":  NSDate().stringFromDate(), "mac_address": UIDevice.currentDevice().identifierForVendor!.UUIDString]
        
        // Create the request
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        do {
            request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(postParams, options: NSJSONWritingOptions())
            print(postParams)
        } catch {
            print("bad things happened")
        }
        
        // Make the POST call and handle it in a completion handler
        session.dataTaskWithRequest(request, completionHandler: { ( data: NSData?, response: NSURLResponse?, error: NSError?) in
            // Make sure we get an OK response
            guard let realResponse = response as? NSHTTPURLResponse where
                realResponse.statusCode == 200 else {
                    print("Not a 200 response")
                    return
            }
            
        }).resume()
    }
    
    // Posts the International Data to Web API
    func postInternationalData(){
        let postEndpoint: String = "http://www.melbournecloudstudio.com/internationals"
        let url = NSURL(string: postEndpoint)!
        let session = NSURLSession.sharedSession()
        let postParams : [String: AnyObject] = ["tapped_timestamp":  NSDate().stringFromDate(), "mac_address": UIDevice.currentDevice().identifierForVendor!.UUIDString]
        
        // Create the request
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        do {
            request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(postParams, options: NSJSONWritingOptions())
            print(postParams)
        } catch {
            print("bad things happened")
        }
        
        // Make the POST call and handle it in a completion handler
        session.dataTaskWithRequest(request, completionHandler: { ( data: NSData?, response: NSURLResponse?, error: NSError?) in
            // Make sure we get an OK response
            guard let realResponse = response as? NSHTTPURLResponse where
                realResponse.statusCode == 200 else {
                    print("Not a 200 response")
                    return
            }
            
        }).resume()
    }
    
    
}



