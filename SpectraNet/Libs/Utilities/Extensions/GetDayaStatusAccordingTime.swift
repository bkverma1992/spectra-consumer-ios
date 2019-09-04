//
//  GetDayaStatusAccordingTime.swift
//  SpectraNet
//
//  Created by Bhoopendra on 7/30/19.
//  Copyright © 2019 Bhoopendra. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController
{
    func getGreetingTime() -> String
    {
        var greeting = String()

        //date formatter
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"

        // Get current time and format it to compare
        var currentTime = Date()
        let currentTimeStr = dateFormatter.string(from: currentTime)
        currentTime = dateFormatter.date(from: currentTimeStr)!

        //Times array
        let startTimes = ["4:00 AM", //Morning
            "12:00 PM", //Aftenoon
            "4:00 PM", //Evening
            "9:00 PM" //Night
        ]

        let morning = 0
        let afternoon = 1
        let evening = 2
        let night = 3

        var dateTimes = [Date]()

        //create an array with the desired times
        for i in 0..<startTimes.count{
            let dateTime = dateFormatter.date(from: startTimes[i])
            print(dateTime!)
            dateTimes.append(dateTime!)
        }

        if currentTime >= dateTimes[morning] && currentTime < dateTimes[afternoon]   {
            greeting = "Good Morning"
        }
        if currentTime >= dateTimes[afternoon] && currentTime < dateTimes[evening]   {
            greeting = "Good Afternoon"
        }
        if currentTime >= dateTimes[evening] && currentTime <= dateTimes[night]   {
            greeting = "Good Evening"
        }
        if currentTime >= dateTimes[night] && currentTime < dateTimes[morning]   {
            greeting = "Good Evening"
        }

        return greeting
        }
    
    func setViewFraming(outOfData: Float, usageData: Float,viewHeight: Float, viewYorigin: Float) -> Float
    {
        var calculatedData = Float()
        calculatedData = usageData/outOfData
        var totlalDataPercentage = Float()
        totlalDataPercentage = calculatedData*100
        
        var calculateViewHeight = Float()
        calculateViewHeight = viewHeight*totlalDataPercentage
        
        var final = Float()
        final = viewYorigin+calculateViewHeight/100
        return final
    }
    
    func isLeapYear (year : String )-> Bool{
        let date = year
        let dateFormatter3 = DateFormatter()
        dateFormatter3.dateFormat = DateFormats.orderCurrentDateFormatOutPut
        let curretYear = dateFormatter3.date(from: date as String)
        let cal = NSCalendar.current
        let year = cal.component(.year, from: (curretYear)!)
        return (( year%100 != 0) && (year%4 == 0)) || year%400 == 0;
    }
    
    func daysBetweenDates(startDate: NSString, endDate: NSString) -> Int {
        
        let endDate = endDate
        let dateFormatter3 = DateFormatter()
        dateFormatter3.dateFormat = DateFormats.orderCurrentDateFormatOutPut
        let end = dateFormatter3.date(from: endDate as String)
        let startDate = startDate
        let dateFormatter2 = DateFormatter()
        dateFormatter2.dateFormat = DateFormats.orderCurrentDateFormatOutPut
        let start = dateFormatter2.date(from: startDate as String)
        let calendar = Calendar.current
        let components = calendar.dateComponents([Calendar.Component.day], from: start!, to: end!)
        return components.day!
    }
    
}

