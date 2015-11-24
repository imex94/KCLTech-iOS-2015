//
//  HCHackathonProvider.swift
//  Hackalendar
//
//  Created by Alex Telek on 10/11/2015.
//  Copyright © 2015 Alex Telek. All rights reserved.
//

import UIKit

class HCHackathonProvider: NSObject {

    static let baseURL = "http://www.hackalist.org/api/1.0/"
    
    class func provideHackathonsFor(month: Int, completionBlock: ([HCHackathon]) -> Void) {
        
        let dateComponents = NSCalendar.currentCalendar().components(.Year, fromDate: NSDate())
        let year = dateComponents.year
        
        provideHackathonsFor(year, month: month, completionBlock: completionBlock)
    }
    
    class func provideHackathonsFor(year: Int, month: Int, completionBlock: ([HCHackathon]) -> Void) {
        
        // hackalist.org/api/1.0/2015/12.json
        let urlString = baseURL + "\(year)/\(month).json"
        
        HCServer.sharedServer().GET(urlString) { (response) -> Void in
            
            var parsedHackathons = [HCHackathon]()
            
            switch response {
                case .Failure(_): print("Failed to fetch data")
                case .Success(let data):
                
                    if let json = data as? Dictionary<NSObject, AnyObject> {
                        
                        let monthString = NSDateFormatter().monthSymbols[month - 1]
                        let hackathons = json[monthString] as! Array<Dictionary<String, String>>
                        
                        for hackathon in hackathons {
                            
                            let hackathonObject = HCHackathon(title: hackathon["title"])
                            hackathonObject.url = NSURL(string: hackathon["url"]!)
                            hackathonObject.startDate = hackathon["startDate"]
                            hackathonObject.endDate = hackathon["endDate"]
                            hackathonObject.year = Int(hackathon["year"]!)
                            hackathonObject.city = hackathon["city"]
                            hackathonObject.host = hackathon["host"]
                            hackathonObject.length = Int(hackathon["length"]!)
                            hackathonObject.size = hackathon["size"]! == "unknown" ? 0 : Int(hackathon["size"]!)
                            
                            let travel = hackathon["travel"]!
                            switch travel {
                                case "yes": hackathonObject.travel = true
                                case "no" : hackathonObject.travel = false
                                case "unknown" : hackathonObject.travel = nil
                                default: hackathonObject.travel = nil
                            }
                            
                            hackathonObject.prize = hackathon["prize"]! == "yes" ? true : false
                            hackathonObject.highSchoolers = hackathon["highSchoolers"]! == "yes" ? true : false
                            hackathonObject.facebookURL = NSURL(string: hackathon["facebookURL"]!)
                            hackathonObject.twitterURL = NSURL(string: hackathon["twitterURL"]!)
                            hackathonObject.googlePlusURL = NSURL(string: hackathon["googlePlusURL"]!)
                            hackathonObject.notes = hackathon["notes"]
                            
                            parsedHackathons.append(hackathonObject)
                        }
                    }
            }
            
            completionBlock(parsedHackathons)
        }
    }
}
