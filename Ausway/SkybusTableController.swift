//
//  SkybusTableController.swift
//  Ausway
//
//  Created by Chandan Singh on 21/04/2016.
//  Copyright © 2016 RMIT. All rights reserved.
//

import UIKit
import SwiftyJSON

class SkybusTableController: UITableViewController, UINavigationControllerDelegate {
    
    var skybust1: [SkybusT1]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Skybus"
        navigationController?.delegate = self
        skybust1 = [SkybusT1]()
        
        addSkybusT1Data()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        navigationController?.navigationBarHidden = false
        //self.tabBarController?.title = "Taxi Services"
        self.tableView.scrollEnabled = true
    }
    
    // How many sections in the table?
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    // How many rows in the table?
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return skybust1.count
    }
    
    // The content of the table
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("skybuscell", forIndexPath: indexPath) as! SkybusTableView
        
        let tableCell = skybust1[indexPath.row]
        
        cell.mainLabel.text = tableCell.timetable
        cell.subtitleLabel.text = tableCell.leftTime
        
        return cell
        
    }
    
    // Fetches all the skybus data from all terminals
    func addSkybusT1Data() {
        RestAPIManager.sharedInstance.url = "http://www.melbournecloudstudio.com/skybus_t1s/allTimeQueries"
        RestAPIManager.sharedInstance.getRandomItem { (json: JSON) in
            
            for n in json {
                let ids = n.1["id"].intValue
                let time = n.1["timetable"].stringValue
                let timeIn = NSDate().timeInterval(time)
                let newSkybus = SkybusT1(id: ids, timetable: time, leftTime: timeIn)
                self.skybust1.append(newSkybus)
            }
            dispatch_async(dispatch_get_main_queue(),{
                self.tableView.reloadData()
            })
            
        }
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
    
    func timeInterval(dates: String) -> String {
        var intes = String()
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm"
        
        var some = dateFormatter.stringFromDate(NSDate())
        some.replaceRange(Range<String.Index>(some.endIndex.advancedBy(-5) ..< some.endIndex), with: dates)
            
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
            intes = toAppend
        } else {
            let toAppend = hh + " hour" + " " + mm + " mins"
            intes = toAppend
        }
            
        
        return intes
        
    }
}





