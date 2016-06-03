//
//  TaxiStand.swift
//  Ausway
//
//  Created by Chandan Singh on 1/06/2016.
//  Copyright © 2016 RMIT. All rights reserved.
//
// This class was implemented later to change the taxi table page as per the new requirements from the client.

import Foundation
import UIKit
struct TaxiStand {
    var heading: String
    var items: [String]
    
    
    init(title: String, objects: [String]) {
        heading = title
        items = objects
    }
}
