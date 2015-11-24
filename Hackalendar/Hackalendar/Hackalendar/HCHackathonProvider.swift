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
    
    class func loadHackathons(year: Int, month: Int) -> [HackathonItem] {
        
        return HackathonItem.fetchHackathons("year == %@ && month == %@", args: [year, month], sortKeywords: ["year", "month"])
    }
    
    class func provideHackathonsFor(month: Int, completionBlock: ([HackathonItem]) -> Void) {
        
        let dateComponents = NSCalendar.currentCalendar().components(.Year, fromDate: NSDate())
        let year = dateComponents.year
        
        provideHackathonsFor(year, month: month, completionBlock: completionBlock)
    }
    
    class func provideHackathonsFor(year: Int, month: Int, completionBlock: ([HackathonItem]) -> Void) {
        
        // hackalist.org/api/1.0/2015/12.json
        let urlString = baseURL + "\(year)/\(month).json"
        
        HCServer.sharedServer().GET(urlString) { (response) -> Void in
            
            var parsedHackathons = [HackathonItem]()
            
            switch response {
                case .Failure(_): print("Failed to fetch data")
                case .Success(let data):
                
                    if let json = data as? Dictionary<NSObject, AnyObject> {
                        
                        // Remove before fetching
                        HackathonItem.removeHackathons(year, month: month)
                        
                        let monthString = NSDateFormatter().monthSymbols[month - 1]
                        let hackathons = json[monthString] as! Array<Dictionary<String, String>>
                        
                        for hackathon in hackathons {
                            
                            let hackathonObject = HackathonItem.item()
                            hackathonObject.title = hackathon["title"]
                            hackathonObject.url = hackathon["url"]
                            hackathonObject.startDate = hackathon["startDate"]
                            hackathonObject.endDate = hackathon["endDate"]
                            hackathonObject.year = Int(hackathon["year"]!)
                            hackathonObject.city = hackathon["city"]
                            hackathonObject.host = hackathon["host"]
                            hackathonObject.length = Int(hackathon["length"]!)
                            hackathonObject.size = hackathon["size"]
                            hackathonObject.travel = hackathon["travel"]
                            hackathonObject.prize = hackathon["prize"]! == "yes" ? true : false
                            hackathonObject.highSchoolers = hackathon["highSchoolers"]! == "yes" ? true : false
                            hackathonObject.facebookURL = hackathon["facebookURL"]
                            hackathonObject.twitterURL = hackathon["twitterURL"]
                            hackathonObject.googlePlusURL = hackathon["googlePlusURL"]
                            hackathonObject.notes = hackathon["notes"]
                            hackathonObject.month = month
                            
                            HCDataManager.saveContext()
                            
                            parsedHackathons.append(hackathonObject)
                        }
                    }
            }
            
            completionBlock(parsedHackathons)
        }
    }
}
