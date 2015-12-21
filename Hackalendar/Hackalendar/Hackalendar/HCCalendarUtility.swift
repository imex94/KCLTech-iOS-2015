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
class HCCalendarUtility: NSObject {

    /**
        Get current year.
    */
    class func getCurrentYear() -> Int {
        
        let dateComponents = NSCalendar.currentCalendar().components(.Year, fromDate: NSDate())
        return dateComponents.year
    }
    
    /**
        Get current month
    */
    class func getCurrentMonth() -> Int {
        
        let dateComponents = NSCalendar.currentCalendar().components(.Month, fromDate: NSDate())
        return dateComponents.month
    }
    
    /**
        Get month names in an array
    */
    class func getMonths() -> [String] {
        
        return NSDateFormatter().monthSymbols
    }
    
    class func getETADays(dateString: String) -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MMMM dd"
        let date = dateFormatter.dateFromString(dateString)
        
        let components = NSCalendar.currentCalendar().components(.Day, fromDate: NSDate(), toDate: date!, options: .MatchStrictly)
        
        let days = components.day
        if days < 0 {
            return "Finished"
        } else {
            return "\(days) days"
        }
    }
}
