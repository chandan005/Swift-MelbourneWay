//
//  PopOverController.swift
//  Ausway
//
//  Created by Chandan Singh on 15/04/2016.
//  Copyright © 2016 RMIT. All rights reserved.
//

import UIKit
import SwiftyJSON


protocol PopOverControllerDelegate {
    func sendTimeTable(array: [SkybusT1]!)
}

class PopOverController: UIViewController {
    
    // Mark: Properties
    
    var delegate: PopOverControllerDelegate?
    
    var senderTag: Int?
    
    var arr = [String]()
    
    var time = [String]()
    
    var senders: UIButton!
    
    var skybust1: [SkybusT1]!
    
    var ssid: String = ""
    
    var bssid: String = ""
    
    var mac_address: String = ""
    
    var nearbyPoint: String = ""
    
    

    // Outlet for done button
    @IBOutlet weak var done: UIButton!
    
    // Outlet for terminal segment buttons
    @IBOutlet weak var t1t2t3: UISegmentedControl!
    
    @IBOutlet weak var passengerType: UISegmentedControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        senderTag = done.tag
        self.title = "Preferences"
        
        done.layer.cornerRadius = 8
        
        skybust1 = [SkybusT1]()
    
        
        addSkybusT1Data()
    }
    

    
    //Mark: Actions
    
    // Show data based on the selected segment
    @IBAction func terminalChanged(sender: UISegmentedControl) {
            }
    
    
    
    @IBAction func doneAction(sender: AnyObject) {
        
        
        switch t1t2t3.selectedSegmentIndex {
        case 0:
            addSkybusT1Data()
            switch self.senders.tag {
            case 1:
                self.skybust1.removeFirst(10)
                
            case 2:
                self.skybust1.removeFirst(5)
                
            case 3:
                self.skybust1.removeFirst(2)
                
            default:
                break
            }
            self.time = NSDate().timeInterval(self.arr)
            delegate?.sendTimeTable(self.skybust1)
            
        case 1:
            addSkybusT3Data()
            switch self.senders.tag {
            case 1:
                self.skybust1.removeFirst(10)
                
            case 2:
                self.skybust1.removeFirst(5)
                
            case 3:
                self.skybust1.removeFirst(2)
                
            default:
                break
            }
            self.time = NSDate().timeInterval(self.arr)
            delegate?.sendTimeTable(self.skybust1)
            
        case 2:
            addSkybusT4Data()
            switch self.senders.tag {
            case 1:
                self.skybust1.removeFirst(10)
                
            case 2:
                self.skybust1.removeFirst(5)
                
            case 3:
                self.skybust1.removeFirst(2)
                
            default:
                break
            }
            self.time = NSDate().timeInterval(self.arr)
            delegate?.sendTimeTable(self.skybust1)
            
        default:
            break
        }

    }
    
    
    
    
    @IBAction func passengerSelected(sender: UISegmentedControl? = nil) {
        switch passengerType.selectedSegmentIndex {
        case 0:
            postDomesticData()
            
            
        case 1:
            postInternationalData()
            
        default:
            break
        }
    }
    
    func addSkybusT1Data() {
        RestAPIManager.sharedInstance.url = "http://localhost:3000/skybus_t1s/timeQueries"
        RestAPIManager.sharedInstance.getRandomItem { (json: JSON) in
            
            for n in json {
                let ids = n.1["id"].intValue
                let time = n.1["timetable"].stringValue
                let newSkybus = SkybusT1(id: ids, timetable: time)
                self.skybust1.append(newSkybus)
            }
            dispatch_async(dispatch_get_main_queue(),{
                
            })
            
        }
    }
    
    func addSkybusT3Data() {
        RestAPIManager.sharedInstance.url = "http://localhost:3000/skybus_t3s/timeQueries"
        RestAPIManager.sharedInstance.getRandomItem { (json: JSON) in
            
            for n in json {
                let ids = n.1["id"].intValue
                let time = n.1["timetable"].stringValue
                let newSkybus = SkybusT1(id: ids, timetable: time)
                self.skybust1.append(newSkybus)
            }
            dispatch_async(dispatch_get_main_queue(),{
                
            })
            
        }
    }
    func addSkybusT4Data() {
        RestAPIManager.sharedInstance.url = "http://localhost:3000/skybus_t4s/timeQueries"
        RestAPIManager.sharedInstance.getRandomItem { (json: JSON) in
            
            for n in json {
                let ids = n.1["id"].intValue
                let time = n.1["timetable"].stringValue
                let newSkybus = SkybusT1(id: ids, timetable: time)
                self.skybust1.append(newSkybus)
            }
            dispatch_async(dispatch_get_main_queue(),{
                
            })
            
        }
    }
    
    func postDomesticData(){
        let postEndpoint: String = "http://localhost:3000/domestics"
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
    
    func postInternationalData(){
        let postEndpoint: String = "http://localhost:3000/internationals"
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

// Extension to convert dates to string and vice versa
extension NSDate{
    func dateFromString(date: String) -> NSDate {
        let formatter = NSDateFormatter()
        formatter.dateStyle = NSDateFormatterStyle.MediumStyle
        formatter.timeStyle = NSDateFormatterStyle.ShortStyle
        formatter.locale = NSLocale.currentLocale()
        let dates = formatter.dateFromString(date)
        return dates!
    }
    
    func stringFromDate() -> String {
        let formatter = NSDateFormatter()
        formatter.dateStyle = NSDateFormatterStyle.MediumStyle
        formatter.timeStyle = NSDateFormatterStyle.ShortStyle
        formatter.locale = NSLocale.currentLocale()
        let dateString = formatter.stringFromDate(self)
        return dateString
    }
    
    func timeInterval(dates: [String]) -> [String] {
        var intes = [String]()
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm"
        
        for date in dates {
            var some = dateFormatter.stringFromDate(NSDate())
            some.replaceRange(Range<String.Index>(some.endIndex.advancedBy(-5) ..< some.endIndex), with: date)
            
            let newDates = dateFormatter.dateFromString(some)
            let current = NSDate()
            let calendar = NSCalendar.currentCalendar()
            let dateComponents = calendar.components([.Hour, .Minute],fromDate: current, toDate: newDates!, options: [])
            let hour = dateComponents.hour
            let minutes = dateComponents.minute
            
            let hh = String(hour)
            let mm = String(minutes)
            
            if hh == "0" {
                let toAppend = hh + " hour" + " " + mm + " mins"
                intes.append(toAppend)
            } else {
                let toAppend = hh + " hour" + " " + mm + " mins"
                intes.append(toAppend)
            }
            
        }
        return intes
        
    }
}

// Extension to remove elements from array
extension Array where Element: Equatable{
    mutating func removeObject(object: Element) {
        if let index = self.indexOf(object) {
            self.removeAtIndex(index)
        }
    }
    
    mutating func removeObjectsInArray(array: [Element]) {
        for object in array {
            self.removeObject(object)
        }
    }
}


