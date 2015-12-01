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
    
    /**
        Load Hackathons from local storage and not from the network. Therefore
        all the hackathon that matches to the specified year and month will be given
        back to us straingth after the method call.
        If this method call return an empty array -> Need to call provideHackathonsFor(...) method
    */
    class func loadHackathons(year: Int, month: Int) -> [HackathonItem] {
        
        // --> What I was doing wrong :), we need to have %@, which means that '%@' will be
        // replaced by the elements from the args array in order.
        return HackathonItem.fetchHackathons("year == %@ && month == %@", args: [year, month], sortKeywords: ["startDate"])
    }
    
    /**
        Providehackathons method for fetching hackathons for a specified month in the current year
        from the API above
    */
    class func provideHackathonsFor(month: Int, completionBlock: ([HackathonItem]) -> Void) {
        
        provideHackathonsFor(HCCalendarUtility.getCurrentYear(), month: month, completionBlock: completionBlock)
    }
    
    /**
        Providehackathons method for fetching hackathons for a specified year and
        month from the API above
    */
    class func provideHackathonsFor(year: Int, month: Int, completionBlock: ([HackathonItem]) -> Void) {
        
        // hackalist.org/api/1.0/2015/12.json
        let urlString = baseURL + "\(year)/\(month).json"
        
        HCServer.sharedServer().GET(urlString) { (response) -> Void in
            
            var parsedHackathons = [HackathonItem]()
            
            switch response {
                case .Failure(_): print("Failed to fetch data")
                case .Success(let data):
                
                    if let json = data as? Dictionary<NSObject, AnyObject> {
                        
                        // Remove data that is metching the year and month we just about to fetch
                        // so we won't have any duplicate value in the database
                        HackathonItem.removeHackathons(year, month: month)
                        
                        let monthString = HCCalendarUtility.getMonths()[month - 1]
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
