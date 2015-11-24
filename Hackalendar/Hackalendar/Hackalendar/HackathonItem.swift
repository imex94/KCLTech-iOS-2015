//
//  HackathonItem.swift
//  Hackalendar
//
//  Created by Clarence Ji on 11/17/15.
//  Copyright © 2015 Alex Telek. All rights reserved.
//

import Foundation
import CoreData

class HackathonItem: NSManagedObject {

    private static let entityName = "HackathonItem"

    class func item() -> HackathonItem {
        
        if let entityDescription = NSEntityDescription.entityForName(entityName, inManagedObjectContext: HCDataManager.managedObjectContext()) {
         
            return HackathonItem(entity: entityDescription, insertIntoManagedObjectContext: HCDataManager.managedObjectContext())
        }
        
        return HackathonItem()
    }
    
    class func fetchHackathons(format: String, args: [AnyObject]?) -> [HackathonItem] {
        
        return fetchHackathons(format, args: args, sortKeywords: [])
    }
    
    class func fetchHackathons(format: String, args: [AnyObject]?, sortKeywords: [String]) -> [HackathonItem] {
                
        let request = NSFetchRequest(entityName: entityName)
        
        let predicate = NSPredicate(format: format, argumentArray: args)
        request.predicate = predicate
        
        for keyword in sortKeywords {
            
            let sort = NSSortDescriptor(key: keyword, ascending: true)
            request.sortDescriptors?.append(sort)
        }
        
        do {
            
            if let hackathons = try HCDataManager.managedObjectContext().executeFetchRequest(request) as? [HackathonItem] {
                
                return hackathons
            }
            
        } catch {
            
            print("Error fetching hackathons: \(error)")
        }
        
        return []
    }
    
    class func removeHackathons(year: Int, month: Int) {
        
        let toDelete = fetchHackathons("year == %@ && month == %@", args: [year, month])
        
        for hackathon in toDelete {
            HCDataManager.managedObjectContext().deleteObject(hackathon)
        }
    }
}
