//
//  SkybusT1.swift
//  Ausway
//
//  Created by Chandan Singh on 25/05/2016.
//  Copyright © 2016 RMIT. All rights reserved.
//
// Struct to hold Skybus value after getting the data from API as JSON
import Foundation

struct SkybusT1 {
    var id: Int
    var timetable: String
    var leftTime: String
}