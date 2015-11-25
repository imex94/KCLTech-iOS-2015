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

    /**
        Class function to create a new HackathonItem instance in the database
        insertIntoManagedObjectConext will insert the new HackathonItem row into the
        current database. Initially the item is empty, we have to directly assign the variables
    */
    class func item() -> HackathonItem {
        
        if let entityDescription = NSEntityDescription.entityForName(entityName, inManagedObjectContext: HCDataManager.managedObjectContext()) {
         
            return HackathonItem(entity: entityDescription, insertIntoManagedObjectContext: HCDataManager.managedObjectContext())
        }
        
        return HackathonItem()
    }
    
    /**
        Convenience method to fetch hackathons based on the format given
        without any sorting.
    */
    class func fetchHackathons(format: String, args: [AnyObject]?) -> [HackathonItem] {
        
        return fetchHackathons(format, args: args, sortKeywords: [])
    }
    
    /**
        Class method to fetch hackathons from the local storage based on 
        the boolean expression format given and also sort them based on the keywords provided
    */
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
    
    /**
        Class function for removing hackathons from the database for the given yearn and month
        For instance, 2015-12, will remove all the hackathons in 2015-December.
    */
    class func removeHackathons(year: Int, month: Int) {
        
        let toDelete = fetchHackathons("year == %@ && month == %@", args: [year, month])
        
        for hackathon in toDelete {
            HCDataManager.managedObjectContext().deleteObject(hackathon)
        }
    }
}
