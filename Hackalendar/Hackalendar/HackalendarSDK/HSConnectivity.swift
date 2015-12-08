//
//  HSConnectivity.swift
//  Hackalendar
//
//  Created by Alex Telek on 08/12/2015.
//  Copyright © 2015 Alex Telek. All rights reserved.
//

import UIKit

public enum MessageType {
    case Forward
    case Reply
}

public class HSConnectivity: NSObject {

    public var messageType: MessageType
    public var hackathons: [HSHackathon]
    
    public init(messageType: MessageType, hackathons: [HSHackathon]) {
        self.messageType = messageType
        self.hackathons = hackathons
    }
    
    public func serializeObject() -> Dictionary<String, AnyObject> {
        var payload = Dictionary<String, AnyObject>()
        
        payload["messageType"] = messageType == .Forward ? "Forward" : "Reply"
        var hackArray = Array<Dictionary<String, String>>()
        
        for hackathon in hackathons {
            var hackDict = Dictionary<String, String>()
            hackDict["title"] = hackathon.title
            hackDict["url"] = hackathon.url
            hackDict["startDate"] = hackathon.startDate
            hackDict["endDate"] = hackathon.endDate
            hackDict["year"] = hackathon.year?.stringValue
            hackDict["city"] = hackathon.city
            hackDict["host"] = hackathon.host
            hackDict["length"] = hackathon.length?.stringValue
            hackDict["size"] = hackathon.size
            hackDict["travel"] = hackathon.travel
            hackDict["prize"] = hackathon.prize?.stringValue
            hackDict["highSchoolers"] = hackathon.highSchoolers?.stringValue
            hackDict["facebookURL"] = hackathon.facebookURL
            hackDict["twitterURL"] = hackathon.twitterURL
            hackDict["googlePlus"] = hackathon.googlePlusURL
            hackDict["notes"] = hackathon.notes
            hackDict["month"] = hackathon.month?.stringValue
            
            hackArray.append(hackDict)
        }
        
        payload["hackathons"] = hackArray
        
        return payload
    }
    
    public class func deserializeObject(payload: Dictionary<String, AnyObject>) -> [HSHackathonObject] {
        let messageType = (payload["messageType"] as? String) == "Forward" ? MessageType.Forward : MessageType.Reply
        var hackathons = [HSHackathonObject]()
        
        let hackArray = payload["hackathons"]?["hackathons"] as! Array<Dictionary<String, String>>
        for hackDict in hackArray {
            let hackathon = HSHackathonObject()
            hackathon.title = hackDict["title"]
            hackathon.url = hackDict["url"]
            hackathon.startDate = hackDict["startDate"]
            hackathon.endDate = hackDict["endDate"]
            hackathon.year = Int(hackDict["year"]!)
            hackathon.city = hackDict["city"]
            hackathon.host = hackDict["host"]
            hackathon.length = Int(hackDict["length"]!)
            hackathon.size = hackDict["size"]
            hackathon.travel = hackDict["travel"]
            hackathon.prize = Int(hackDict["prize"]!)
            hackathon.highSchoolers = Int(hackDict["highSchoolers"]!)
            hackathon.facebookURL = hackDict["facebookURL"]
            hackathon.twitterURL = hackDict["twitterURL"]
            hackathon.googlePlusURL = hackDict["googlePlus"]
            hackathon.notes = hackDict["notes"]
            hackathon.month = Int(hackDict["month"]!)
            
            hackathons.append(hackathon)
        }
        
        return hackathons
    }
}
