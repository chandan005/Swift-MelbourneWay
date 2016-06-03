//
//  WeatherController.swift
//  Ausway
//
//  Created by Chandan Singh on 28/04/2016.
//  Copyright © 2016 RMIT. All rights reserved.
//
// Fetches the Weather data from open weather map API

import UIKit

class WeatherController: UIViewController {
    
    
    @IBOutlet weak var weatherType: UILabel!
    
    @IBOutlet weak var temperature: UILabel!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.title = "Weather"
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background.png")!)
        
        
        if let url = NSURL(string: "http://api.openweathermap.org/data/2.5/weather?q=Melbourne,au&appid=2d510ace4a0ebc5df0f9d15d0e541569"){
            if let data = NSData(contentsOfURL: url){
                do {
                    
                    // Transfer data toNSJONSerialization
                    let parsed = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments)
                    
                    // Make a variable "newDict" and transfer to NSDictionary
                    let newDict = parsed as? NSDictionary
                    
                    // To get the value from "newDict"
                    let newTempk = (newDict!["main"]!["temp"]!!)
                    let newTempc = newTempk.doubleValue - 273.15
                    let intTemp: Int = Int(newTempc)
                    //let newWindSpeed = (newDict!["wind"]!["speed"]!!).doubleValue
                    //let newWeatherDescription = (newDict!["weather"]![0]!["description"]!!)
                    
                    // To show current temperature, Humidity, weather description, Wind Speed
                    self.temperature.text = "\(intTemp)"+"°C"
                    //self.currentHumidity.text = "Humidity: "+"\(newDict!["main"]!["humidity"]!!)"+"%"
                    self.weatherType.text = "\u{f010}"
                    //self.currentWind.text = "Wind Speed: "+"\(newWindSpeed)"+"m/s"
                }
                    // To catch any error
                catch let error as NSError{
                    print("error\(error)")
                }
            }
        }
    }
    
   
    
   
}
