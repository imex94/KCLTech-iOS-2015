//
//  HCHackathonSerialization.swift
//  Hackalendar
//
//  Created by Alex Telek on 08/12/2015.
//  Copyright © 2015 Alex Telek. All rights reserved.
//

import UIKit

class HCHackathonSerialization: NSObject {

    class func serializeObject(hackathons: [HackathonItem]) -> Dictionary<String, AnyObject> {
        var hackDict = Dictionary<String, AnyObject>()
        
        var hackArray = Array<Dictionary<String, String>>()
        
        for hackathon in hackathons {
            var dict = Dictionary<String, String>()
            
            dict["title"] = hackathon.title
            dict["url"] = hackathon.url
            dict["startDate"] = hackathon.startDate
            dict["endDate"] = hackathon.endDate
            dict["year"] = hackathon.year?.stringValue
            dict["city"] = hackathon.city
            dict["host"] = hackathon.host
            dict["length"] = hackathon.length?.stringValue
            dict["travel"] = hackathon.travel
            dict["prize"] = hackathon.prize?.stringValue
            dict["highSchoolers"] = hackathon.highSchoolers?.stringValue
            dict["facebookURL"] = hackathon.facebookURL
            dict["twitterURL"] = hackathon.twitterURL
            dict["googlePlusURL"] = hackathon.googlePlusURL
            dict["notes"] = hackathon.notes
            dict["month"] = hackathon.month?.stringValue
            
            hackArray.append(dict)
        }
        
        hackDict["hackathons"] = hackArray
        
        return hackDict
    }
}
