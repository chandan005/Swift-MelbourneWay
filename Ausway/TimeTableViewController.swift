//
//  TimeTableViewController.swift
//  Ausway
//
//  Created by Chandan Singh on 19/04/2016.
//  Copyright © 2016 RMIT. All rights reserved.
//

import UIKit
import SwiftyJSON

class TimeTableViewController: UITableViewController, UINavigationControllerDelegate {
    
    // Stores data from previous array
    var skybust1: [SkybusT1]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Next5"
        navigationController?.delegate = self
        
    }
    
    override func viewWillAppear(animated: Bool) {
        navigationController?.navigationBarHidden = false
        //self.tabBarController?.title = "Next5 Services"
        self.tableView.scrollEnabled = true
    }
    
    // How many sections in the table?
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
     return 1
     }
     
     // How many rows in the table?
     override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     return 5
     }
     
     // The content of the table
     override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("tables", forIndexPath: indexPath) as! NextTableView
        
        let tableCell = skybust1[indexPath.row]
        
        cell.timeLabel.text = tableCell.timetable
        cell.subtitleLabel.text = "00 Hrs 00 Mins"
        
        return cell

     }
    
        
    // Removes all the data from array upon clicking back button
    /*func navigationController(navigationController: UINavigationController, willShowViewController viewController: UIViewController, animated: Bool) {
        if let controller = viewController as? PopOverController {
            controller.arr.removeAll()
            controller.time.removeAll()
            controller.passengerType.selectedSegmentIndex = -1
            controller.t1t2t3.selectedSegmentIndex = -1
        }
    }*/
    
}

