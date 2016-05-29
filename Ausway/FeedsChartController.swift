//
//  FeedsChartController.swift
//  Ausway
//
//  Created by Chandan Singh on 28/04/2016.
//  Copyright © 2016 RMIT. All rights reserved.
//

import UIKit
import Charts



class FeedsChartController: UIViewController, ChartViewDelegate {
    
   
    @IBOutlet var pieChartView: PieChartView!
    
    
    
    var tweets: [String]!
    
    var keyWords = [String]()
    
    var counter = [Int] ()
    
    var integerDict = Dictionary<String, Int>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Charts"
        
        
        pieChartView.delegate = self
        
        let tweetss = ["Traffic Alert", "Road Closed", "Roadworks", "Tow Allocation"]
        let tweetUnits = [20, 5, 10, 12]
        
        setChart(tweetss, values: tweetUnits)

    }
    
    func setChart(dataPoints: [String], values: [Int]){
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = ChartDataEntry(value: Double(values[i]), xIndex: i)
            dataEntries.append(dataEntry)
        }
        
        let pieChartDataSet = PieChartDataSet(yVals: dataEntries, label: "")
        let pieChartData = PieChartData(xVals: dataPoints, dataSet: pieChartDataSet)
        pieChartView.data = pieChartData
        
        var colors: [UIColor] = []
        
        for _ in 0..<dataPoints.count {
            let red = Double(arc4random_uniform(256))
            let green = Double(arc4random_uniform(256))
            let blue = Double(arc4random_uniform(256))
            
            let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
            colors.append(color)
        }
        
        pieChartDataSet.colors = colors
        
        pieChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
        
    }
    
    func chartValueSelected(chartView: ChartViewBase, entry: ChartDataEntry, dataSetIndex: Int, highlight: ChartHighlight) {
        print("\(entry.value) in \([entry.xIndex])")
    }
    
    func returnTweetsCount(){
        var roadClosedCount = 0
        var trafficAlertCount = 0
        var roadWorksCount = 0
        var towAllocationCount = 0
        
        //var integerCounted = [Int]()
        for i in self.tweets {
            if i.lowercaseString.containsString("road closed") {
                roadClosedCount += 1
                self.integerDict.updateValue(roadClosedCount, forKey: "Road Closed")
                //integerCounted.insert(roadClosedCount, atIndex: 0)
            }
            if i.lowercaseString.containsString("traffic alert") {
                trafficAlertCount += 1
                self.integerDict.updateValue(trafficAlertCount, forKey: "Traffic Alert")
                //integerCounted.insert(trafficAlertCount, atIndex: 1)
            }
            if i.lowercaseString.containsString("roadworks") {
                roadWorksCount += 1
                self.integerDict.updateValue(roadWorksCount, forKey: "RoadWorks")
                //integerCounted.insert(roadWorksCount, atIndex: 2)
            }
            if i.lowercaseString.containsString("tow allocation") {
                towAllocationCount += 1
                self.integerDict.updateValue(towAllocationCount, forKey: "Tow Allocation")
                //integerCounted.insert(towAllocationCount, atIndex: 3)
            }
        }
        
        for (keywords, count) in self.integerDict {
            self.keyWords.append(keywords)
            self.counter.append(count)
        }
    }
    
    
    
   
}
