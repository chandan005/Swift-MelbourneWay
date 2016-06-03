//
//  EstimateFareController.swift
//  Ausway
//
//  Created by Chandan Singh on 12/05/2016.
//  Copyright © 2016 RMIT. All rights reserved.
//
// View Controller that gets the value from RouteViewController and displays the estimated fare

import UIKit

class EstimateFareController: UIViewController {
    
    
    @IBOutlet weak var travelDetails: UITextView!
    var traveller: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        travelDetails.text = traveller
    }
}
