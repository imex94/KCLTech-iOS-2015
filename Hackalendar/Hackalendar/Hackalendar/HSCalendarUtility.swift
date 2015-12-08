//
//  HTLCalendatUtility.swift
//  Hackalendar
//
//  Created by Alex Telek on 24/11/2015.
//  Copyright © 2015 Alex Telek. All rights reserved.
//

import UIKit

/**
    HTLCalendarUtility, helper methods to get current year, month and month names. All the calendar
    related methods we were using across the project
*/
public class HSCalendarUtility: NSObject {

    public static let DAY = 60 * 60 * 24
    
    /**
        Get current year.
    */
    public class func getCurrentYear() -> Int {
        
        let dateComponents = NSCalendar.currentCalendar().components(.Year, fromDate: NSDate())
        return dateComponents.year
    }
    
    /**
        Get current month
    */
    public class func getCurrentMonth() -> Int {
        
        let dateComponents = NSCalendar.currentCalendar().components(.Month, fromDate: NSDate())
        return dateComponents.month
    }
    
    /**
        Get month names in an array
    */
    public class func getMonths() -> [String] {
        
        return NSDateFormatter().monthSymbols
    }
    
    /**
        Get the number of days until the hackathon
    */
    public class func getDaysLeftUntil(date: String) -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MMMM dd"
        let startDate: NSDate = dateFormatter.dateFromString(date)!
        
        let daysLeft = Int(startDate.timeIntervalSinceDate(NSDate())) / DAY
        print(daysLeft)
        if daysLeft == 0 {
            return "Now"
        } else if daysLeft < 0 {
            return "Finished"
        } else {
            return "in \(daysLeft) days"
        }
    }
}
