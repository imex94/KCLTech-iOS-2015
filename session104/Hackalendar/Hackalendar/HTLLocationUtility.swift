//
//  HTLLocationUtility.swift
//  Hackalendar
//
//  Created by Alex Telek on 07/11/2015.
//  Copyright © 2015 Alex Telek. All rights reserved.
//

import UIKit
import MapKit

class HTLLocationUtility: NSObject {
    
    static let queue = dispatch_queue_create("com.kcltech.hackalendar", DISPATCH_QUEUE_CONCURRENT)
    
    class func extractCityFromLocation(location: String?) -> String? {
        
        guard location != nil else {
            return nil
        }
        
        return location!.characters.split{$0 == ","}.map(String.init).first
    }
    
    class func geolocateCityForLocationName(locationName: String?, completitionHandler: (CLLocationCoordinate2D?) -> Void) {
        
        let searchRequest = MKLocalSearchRequest()
        searchRequest.naturalLanguageQuery = locationName
        
        
        dispatch_async(queue) { () -> Void in
         
            let search = MKLocalSearch(request: searchRequest)
            search.startWithCompletionHandler { (searchResponse, error) -> Void in
                
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    
                    guard searchResponse != nil && searchResponse?.mapItems.count != 0 else {
                        completitionHandler(nil)
                        return
                    }
                    
                    let mapItem = searchResponse!.mapItems.first
                    
                    completitionHandler(mapItem?.placemark.coordinate)
                })
            }
        }
    }
}
