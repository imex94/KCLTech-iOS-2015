//
//  HSHackathon.swift
//  Hackalendar
//
//  Created by Alex Telek on 08/12/2015.
//  Copyright © 2015 Alex Telek. All rights reserved.
//

import Foundation
import CoreData

@objc(HSHackathon)
public class HSHackathon: NSManagedObject {

    private static let entityName = "HSHackathon"
    
    public class func item() -> HSHackathon {
        
        let entityDescription = NSEntityDescription.entityForName(entityName, inManagedObjectContext: HSDataManager.managedObjectContext())
        return HSHackathon(entity: entityDescription!, insertIntoManagedObjectContext: HSDataManager.managedObjectContext())
    }
    
    public class func fetchHackathons(format: String, args: [AnyObject]?) -> [HSHackathon] {
        
        return fetchHackathons(format, args: args, sortKeywords: [])
    }
    
    public class func fetchHackathons(format: String, args: [AnyObject]?, sortKeywords: [String]) -> [HSHackathon] {
        
        let entityDescription = NSEntityDescription.entityForName(entityName, inManagedObjectContext: HSDataManager.managedObjectContext())
        
        let request = NSFetchRequest()
        request.entity = entityDescription
        
        let predicate = NSPredicate(format: format, argumentArray: args)
        request.predicate = predicate
        
        var sortArray = [NSSortDescriptor]()
        
        for keyword in sortKeywords {
            
            let sort = NSSortDescriptor(key: keyword, ascending: false)
            sortArray.append(sort)
        }
        
        request.sortDescriptors = sortArray
        
        do {
            
            if let hackathons = try HSDataManager.managedObjectContext().executeFetchRequest(request) as? [HSHackathon] {
                
                return hackathons
            }
            
        } catch {
            
            print("Error saving HackathonItemConext - \(error)")
        }
        
        return []
    }
    
    public class func removeHackathons(year: Int, month: Int) {
        
        let toDelete = fetchHackathons("year == \(year) && month == \(month)", args: [year, month])
        
        for object in toDelete {
            HSDataManager.managedObjectContext().deleteObject(object)
        }
    }
}
