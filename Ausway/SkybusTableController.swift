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
        cell.subtitleLabel.text = "00 hrs 00 mins"
        
        return cell
        
    }
    
    func addSkybusT1Data() {
        RestAPIManager.sharedInstance.url = "http://localhost:3000/skybus_t1s/allTimeQueries"
        RestAPIManager.sharedInstance.getRandomItem { (json: JSON) in
            
            for n in json {
                let ids = n.1["id"].intValue
                let time = n.1["timetable"].stringValue
                let newSkybus = SkybusT1(id: ids, timetable: time)
                self.skybust1.append(newSkybus)
            }
            dispatch_async(dispatch_get_main_queue(),{
                self.tableView.reloadData()
            })
            
        }
    }
    
   
    
}




