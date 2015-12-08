//
//  HSWLocationUtility.swift
//  Hackalendar
//
//  Created by Alex Telek on 08/12/2015.
//  Copyright © 2015 Alex Telek. All rights reserved.
//

import WatchKit

public class HSWLocationUtility: NSObject {

    /**
     Extract city name from the location.
     For instance the location param is give as: London, United Kingdom.
     That will result London.
     */
    public class func extractCityNameFromLocation(location: String?) -> String? {
        
        if location == nil {
            return ""
        }
        
        return location!.characters.split{$0 == ","}.map(String.init).first
    }
}
