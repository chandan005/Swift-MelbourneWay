//
//  RestAPIManager.swift
//  Ausway
//
//  Created by Chandan Singh on 24/05/2016.
//  Copyright © 2016 RMIT. All rights reserved.
//

import Foundation
import SwiftyJSON

typealias ServiceResponse = (JSON, NSError?) -> Void


class RestAPIManager: NSObject {
    static let sharedInstance = RestAPIManager()
    var url: String!
    
    let baseURL = "http://localhost:3000/taxis"
    
    func getRandomItem(onCompletion: (JSON) -> Void) {
        let route = url
        makeHTTPGetRequest(route, onCompletion: {
            json, err in
            onCompletion(json as JSON)
        })
        
    }
    
    // MARK: Perform a GET Request
    private func makeHTTPGetRequest(path: String, onCompletion: ServiceResponse) {
        let request = NSMutableURLRequest(URL: NSURL(string: path)!)
        
        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            if let jsonData = data {
                let json:JSON = JSON(data: jsonData)
                onCompletion(json, error)
            } else {
                onCompletion(nil, error)
            }
        })
        task.resume()
    }
}
