//
//  HCDataManager.swift
//  Hackalendar
//
//  Created by Clarence Ji on 11/24/15.
//  Copyright © 2015 Alex Telek. All rights reserved.
//

import UIKit
import CoreData

class HCDataManager: NSObject {

    /**
        Class function to get the managed object context that we can work on.
    */
    class func managedObjectContext() -> NSManagedObjectContext {
        
        if let managedObjectContext = (UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext {
            
            return managedObjectContext
        }
        
        return NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
    }
    
    /**
        Class function to save the modified managed objects on the context
    */
    class func saveContext() {
        
        let context = managedObjectContext()
        
        do {
            
            try context.save()
            
        } catch {
            
            print("Error saving context: \(error)")
        }
    }
}
