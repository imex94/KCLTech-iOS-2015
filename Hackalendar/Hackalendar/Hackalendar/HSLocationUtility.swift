//
//  HSLocationUtility.swift
//  Hackalendar
//
//  Created by Clarence Ji on 11/17/15.
//  Copyright © 2015 Alex Telek. All rights reserved.
//

import UIKit
import MapKit

public class HSLocationUtility: NSObject {

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
    
    /**
        Get location coordinates (latitude and longitude) for a location specified
        as a string. For Instance, given by London, United Kingdom will result
        something like this (51.5073509, -0.12775829999998223)
    */
    public class func locateCityForLocationName(location: String?, completitionHandler: (CLLocationCoordinate2D?) -> Void) {
        
        let searchRequest = MKLocalSearchRequest()
        searchRequest.naturalLanguageQuery = location
        
        let search = MKLocalSearch(request: searchRequest)
        search.startWithCompletionHandler { (response, error) -> Void in
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                
                if response == nil || response?.mapItems.count == 0 {
                    
                    completitionHandler(nil)
                    return
                }
                
                let mapItem = response!.mapItems.first
                completitionHandler(mapItem?.placemark.coordinate)
            })
        }
    }
}
