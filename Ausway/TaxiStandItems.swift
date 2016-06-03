//
//  TaxiStandItems.swift
//  Ausway
//
//  Created by Chandan Singh on 1/06/2016.
//  Copyright © 2016 RMIT. All rights reserved.
//
// Class to set the values of taxi table page. This is all dummy data and does not fetch the result from API.
import Foundation
import UIKit

class TaxiStandItems {
    
    func getItemsFromData() -> [TaxiStand]{
        
        var itemsArray = [TaxiStand]()
        
        let taxis1 = TaxiStand(title: "Stand A", objects: ["5 mins", "30 meters", "4 mins", "25 meters", "3 mins", "20 meters", "2 mins", "15 meters", "1 min", "5 meters"])
        
        let taxis2 = TaxiStand(title: "Stand B", objects: ["10 mins", "20 meters", "8 mins", "15 meters", "6 mins", "10 meters", "4 mins", "5 meters", "2 mins", "2 meters"])
        
        let taxis3 = TaxiStand(title: "Stand C", objects: ["12 mins", "22 meters", "10 mins", "17 meters", "8 mins", "12 meters", "6 mins", "7 meters", "4 mins", "3 meters"])
        
        let taxis4 = TaxiStand(title: "Stand D", objects: ["15 mins", "18 meters", "12 mins", "13 meters", "10 mins", "8 meters", "8 mins", "5 meters", "6 mins", "3 meters"])
        
        let taxis5 = TaxiStand(title: "Stand E", objects: ["18 mins", "24 meters", "14 mins", "19 meters", "12 mins", "14 meters", "10 mins", "9 meters", "8 mins", "4 meters"] )
        
        itemsArray.append(taxis1)
        itemsArray.append(taxis2)
        itemsArray.append(taxis3)
        itemsArray.append(taxis4)
        itemsArray.append(taxis5)
        
        return itemsArray
    }
    
}