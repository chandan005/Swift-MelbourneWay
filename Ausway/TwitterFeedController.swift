//
//  TwitterFeedController.swift
//  Ausway
//
//  Created by Chandan Singh on 25/04/2016.
//  Copyright © 2016 RMIT. All rights reserved.
//

import UIKit
import TwitterKit


class TwitterFeedController: TWTRTimelineViewController {
    
    // MARK: Properties
    
    // Search query for Tweets matching the right hashtags and containing an attached poem picture.
    let TrafficSearchQuery = "from:VicRoads"
    
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Twitter"
        
        // Log Answers Custom Event.
        //Answers.logCustomEventWithName("Viewed Tweets Timeline", customAttributes: nil)
        
        let userID = Twitter.sharedInstance().sessionStore.session()?.userID
        let client = TWTRAPIClient(userID: userID)
        self.dataSource = TWTRSearchTimelineDataSource(searchQuery: self.TrafficSearchQuery, APIClient: client)
    
        // Customize the table view.
        let headerHeight: CGFloat = 15
        tableView.tableHeaderView = UIView(frame: CGRectMake(0, 0, tableView.bounds.size.width, headerHeight))
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = UIColor(red: 23.0/255.0, green: 1.0/255.0, blue: 23.0/255.0, alpha: 1.0)
        
        // Customize the navigation bar.
        //title = "Tweets"
        //navigationController?.navigationBar.translucent = true
        
        // Add an initial offset to the table view to show the animated refresh control.
        let refreshControlOffset = refreshControl?.frame.size.height
        tableView.frame.origin.y += refreshControlOffset!
        refreshControl?.tintColor = UIColor.orangeColor()
        refreshControl?.beginRefreshing()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        // Make sure the navigation bar is not translucent when scrolling the table view.
        //navigationController?.navigationBar.translucent = false
        
        // Display a label on the background if there are no recent Tweets to display.
        let noTweetsLabel = UILabel()
        noTweetsLabel.text = "Sorry, there are no recent Tweets to display."
        noTweetsLabel.textAlignment = .Center
        noTweetsLabel.textColor = UIColor.orangeColor()
        noTweetsLabel.font = UIFont(name: "HelveticaNeue", size: CGFloat(14))
        tableView.backgroundView = noTweetsLabel
        tableView.backgroundView?.hidden = true
        tableView.backgroundView?.alpha = 0
        toggleNoTweetsLabel()
    }
    
    // MARK: Utilities
    
    private func toggleNoTweetsLabel() {
        if tableView.numberOfRowsInSection(0) == 0 {
            UIView.animateWithDuration(0.15) {
                self.tableView.backgroundView!.hidden = false
                self.tableView.backgroundView!.alpha = 1
            }
        } else {
            UIView.animateWithDuration(0.15,
                                       animations: {
                                        self.tableView.backgroundView!.alpha = 0
                },
                                       completion: { finished in
                                        self.tableView.backgroundView!.hidden = true
                }
            )
        }
    }
    
   
    
    
}
