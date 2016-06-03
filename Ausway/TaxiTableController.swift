//
//  TaxiTableController.swift
//  Ausway
//
//  Created by Chandan Singh on 21/04/2016.
//  Copyright © 2016 RMIT. All rights reserved.
//

import UIKit
import SwiftyJSON

class TaxiTableController: UITableViewController, UINavigationControllerDelegate {
    
    var sections: [TaxiStand] = TaxiStandItems().getItemsFromData()
    
    var taxis: [TaxiObject]!
    
    var image: [UIImage]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Taxi"
        navigationController?.delegate = self
        
        taxis = [TaxiObject]()
        image = [UIImage(named: "Taxi.png")!, UIImage(named: "Distance.png")!, UIImage(named: "Taxi.png")!, UIImage(named: "Distance.png")!, UIImage(named: "Taxi.png")!, UIImage(named: "Distance.png")!, UIImage(named: "Taxi.png")!, UIImage(named: "Distance.png")!, UIImage(named: "Taxi.png")!, UIImage(named: "Distance.png")!]
        
        addTaxiData()
        
        self.tableView.sectionIndexBackgroundColor = UIColor.orangeColor()
        
   
    }
    
    override func viewWillAppear(animated: Bool) {
        navigationController?.navigationBarHidden = false
        //self.tabBarController?.title = "Taxi Services"
        self.tableView.scrollEnabled = true
    }
    
    // How many sections in the table?
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return sections.count
    }
    
    // How many rows in the table?
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].items.count
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].heading
    }
    
    // The contents of the table
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("taxicell", forIndexPath: indexPath) as! TaxiTableView
    
        cell.taxiLabel.text = sections[indexPath.section].items[indexPath.row]
        cell.taxiImage.image = image[indexPath.row]
        
        return cell
        
    }
    
    // Fetches the Taxi Data from API
    func addTaxiData() {
        RestAPIManager.sharedInstance.url = "http://www.melbournecloudstudio.com/taxis"
        RestAPIManager.sharedInstance.getRandomItem { (json: JSON) in
            
                for n in json {
                    let ids = n.1["id"].intValue
                    let tax = n.1["taxi_number"].stringValue
                    let taxA = n.1["taxi_availability"].intValue
                    let newTaxi = TaxiObject(id: ids, taxi_number: tax, taxi_availability: taxA)
                    self.taxis.append(newTaxi)
                }
            
                dispatch_async(dispatch_get_main_queue(),{
                    self.tableView.reloadData()
                })
            
        }
    }
   
    /*// Alternate Method the retriece the data from API
    func addSomething(){
        let endPoint: String = "http://www.melbournecloudstudio.com/taxis"
        guard let url = NSURL(string: endPoint) else {
            print("Error: cannot create URL")
            return
        }
        let urlRequest = NSURLRequest(URL: url)
        
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: config)
        
        let task = session.dataTaskWithRequest(urlRequest, completionHandler: { (data, response, error) in
            
            //Check for any errors
            guard error == nil else {
                print("Error calling GET on taxis/1")
                print(error)
                return
            }
            
            // Make sure we got the data
            guard let responseData = data else {
                print("Error: did not recieve the data")
                return
            }
            
            // Parse the result as JSON
            let json = JSON(data: responseData)
            print(json.array)
            for n in json{
                let ids = n.1["id"].intValue
                let tax = n.1["taxi_number"].stringValue
                let taxA = n.1["taxi_availability"].intValue
                let newTaxi = TaxiObject(id: ids, taxi_number: tax, taxi_availability: taxA)
                self.taxis.append(newTaxi)
            }
            dispatch_async(dispatch_get_main_queue(), {
                self.tableView.reloadData()
            })
        })
        
        task.resume()
    }*/
   
 
    
}
