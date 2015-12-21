//
//  HCWHackathonDeserialization.swift
//  Hackalendar
//
//  Created by Alex Telek on 08/12/2015.
//  Copyright © 2015 Alex Telek. All rights reserved.
//

import WatchKit

class HCWHackathonDeserialization: NSObject {

    class func deserializeObject(payload: Dictionary<String, AnyObject>) -> [HCWHackathon] {
        
        let hackArray = payload["hackathons"] as! Array<Dictionary<String, String>>
        
        var hackathonsToReturn = [HCWHackathon]()
        for dict in hackArray {
            
            let hack = HCWHackathon()
            
            hack.title = dict["title"]
            hack.url = dict["url"]
            hack.startDate = dict["startDate"]
            hack.endDate = dict["endDate"]
            hack.year = Int(dict["year"]!)
            hack.city = dict["city"]
            hack.host = dict["host"]
            hack.length = Int(dict["length"]!)
            hack.travel = dict["travel"]
            hack.prize = Int(dict["prize"]!)
            hack.highSchoolers = Int(dict["highSchoolers"]!)
            hack.facebookURL = dict["facebookURL"]
            hack.twitterURL = dict["twitterURL"]
            hack.googlePlusURL = dict["googlePlusURL"]
            hack.notes = dict["notes"]
            hack.month = Int(dict["month"]!)
            
            hackathonsToReturn.append(hack)
        }
        
        return hackathonsToReturn
    }
}
