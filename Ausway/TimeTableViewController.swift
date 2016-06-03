//
//  TimeTableViewController.swift
//  Ausway
//
//  Created by Chandan Singh on 19/04/2016.
//  Copyright © 2016 RMIT. All rights reserved.
//
// View Controller responsible for displaying the nest 5 Skybus timetable
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
        cell.subtitleLabel.text = tableCell.leftTime
        
        return cell

     }
    
}

