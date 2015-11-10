//
//  HTLHackathonProvider.swift
//  Hackalendar
//
//  Created by Alex Telek on 07/11/2015.
//  Copyright © 2015 Alex Telek. All rights reserved.
//

import UIKit

class HTLHackathonProvider: NSObject {

    static let baseURL = "http://www.hackalist.org/api/1.0/"

    typealias HTLHackathonProviderCompleitionHandler = ([HTLHackathon]) -> Void
    
    class func provideHackathonsFor(month: Int, block: HTLHackathonProviderCompleitionHandler) {
        
        let dateComponents = NSCalendar.currentCalendar().components(.Year, fromDate: NSDate())
        let year = dateComponents.year
        
        provideHackathonsFor(year, month: month, block: block)
    }
    
    class func provideHackathonsFor(year: Int, month: Int, block: HTLHackathonProviderCompleitionHandler) {
        
        let monthString = month < 10 ? "0\(month)" : "\(month)"
        let urlString = baseURL + "\(year)/\(monthString).json"
        
        HTLServer.sharedServer().GET(urlString) { (response) -> Void in
            
            var parsedHackathons = [HTLHackathon]()
            
            switch response {
                case .Success(let data):
                    
                    // Form of { "November" : [ {...}, {...}, ...]}
                    if let json = data as? Dictionary<NSObject, AnyObject> {
                     
                        let monthString = NSDateFormatter().monthSymbols[month - 1]
                        let hackathons = json[monthString] as! Array<Dictionary<String, String>>
                        
                        for hackathon in hackathons {
                            
                            let hackathonObject = HTLHackathon(title: hackathon["title"])
                            hackathonObject.url = NSURL(string: hackathon["url"]!)
                            hackathonObject.startDate = hackathon["startDate"]
                            hackathonObject.endDate = hackathon["endDate"]
                            hackathonObject.year = Int(hackathon["year"]!)
                            hackathonObject.city = hackathon["city"]
                            hackathonObject.host = hackathon["host"]
                            hackathonObject.length = Int(hackathon["length"]!)
                            hackathonObject.size = hackathon["size"]! == "unknown" ? 0 : Int(hackathon["size"]!)
                            hackathonObject.travel = hackathon["travel"]
                            hackathonObject.prize = hackathon["prize"]! == "yes" ? true : false
                            hackathonObject.highSchoolers = hackathon["highSchoolers"]! == "yes" ? true : false
                            hackathonObject.facebookURL = NSURL(string: hackathon["facebookURL"]!)
                            hackathonObject.twitterURL = NSURL(string: hackathon["twitterURL"]!)
                            hackathonObject.googlePlusURL = NSURL(string: hackathon["googlePlusURL"]!)
                            hackathonObject.notes = hackathon["notes"]
                            
                            hackathonObject.dateCode = "\(year)\(month)"
                            
                            parsedHackathons.append(hackathonObject)
                        }
                    }
                
                case _: print("Failed to fetch data")
            }
            
            block(parsedHackathons)
        }
    }
}
