//
//  AppDelegate.swift
//  Ausway
//
//  Created by Chandan Singh on 15/04/2016.
//  Copyright © 2016 RMIT. All rights reserved.
//

import UIKit
import Fabric
import TwitterKit
import SwiftyJSON
import SystemConfiguration.CaptiveNetwork

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var ssid: String = ""
    
    var bssid: String = ""
    
    var mac_address: String = ""
    
    var nearbyPoint: String = ""


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        //Twitter.sharedInstance().startWithConsumerKey("gpluIQTuMCp4DGt7WRdFzVjC5", consumerSecret:	"UnWz0VFj1JWWEoSEotWmhz6tz8Jj1kCugPQ9X4oDELvtxjiSsL")
        //copyBundledSQLiteDB()
        self.lookForWifi()
        Fabric.with([Twitter.self])
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        self.lookForWifi()
       
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func lookForWifi(){
        if Reachability.isConnectedToNetwork() == true {
            self.getAccessPoint()
            print("Internet Conenction OK")
        } else {
            print("Internet Connection Required")
            let alert = UIAlertController(title: nil, message: "Make sure your device is connected to the internet", preferredStyle: .Alert)
            let okButton = UIAlertAction(title: "OK",
                                         style: .Cancel) { (alert) -> Void in
            }
            alert.addAction(okButton)
            self.window?.rootViewController?.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    func getAccessPoint(){
        if let interfaces:CFArray! = CNCopySupportedInterfaces() {
            for i in 0..<CFArrayGetCount(interfaces){
                let interfaceName: UnsafePointer<Void>
                    =  CFArrayGetValueAtIndex(interfaces, i)
                let rec = unsafeBitCast(interfaceName, AnyObject.self)
                let unsafeInterfaceData = CNCopyCurrentNetworkInfo("\(rec)")
                if unsafeInterfaceData != nil {
                    let interfaceData = unsafeInterfaceData! as Dictionary!
                    self.ssid = interfaceData["SSID"] as! String
                    self.bssid = interfaceData["BSSID"] as! String
                } else {
                    self.ssid = ""
                    self.bssid = ""
                }
            }
        }
        
        let postEndpoint: String = "http://www.melbournecloudstudio.com/access_points"
        let url = NSURL(string: postEndpoint)!
        let session = NSURLSession.sharedSession()
        let postParams : [String: AnyObject] = ["ssid":  self.ssid, "bssid": self.bssid, "mac_address": UIDevice.currentDevice().identifierForVendor!.UUIDString, "nearby_point": ""]
        
        // Create the request
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        do {
            request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(postParams, options: NSJSONWritingOptions())
            print(postParams)
        } catch {
            print("bad things happened")
        }
        
        // Make the POST call and handle it in a completion handler
        session.dataTaskWithRequest(request, completionHandler: { ( data: NSData?, response: NSURLResponse?, error: NSError?) in
            // Make sure we get an OK response
            guard let realResponse = response as? NSHTTPURLResponse where
                realResponse.statusCode == 200 else {
                    print("Not a 200 response")
                    return
            }
            
        }).resume()
        
    }

    
    


}

