//
//  HSDataManager.swift
//  Hackalendar
//
//  Created by Alex Telek on 08/12/2015.
//  Copyright © 2015 Alex Telek. All rights reserved.
//

import UIKit
import CoreData

public class HSDataManager: NSObject {

    public class func managedObjectContext() -> NSManagedObjectContext {
        
        return HSCoreDataProxy.sharedProxy.managedObjectContext
    }
    
    public class func saveContext() {
        
        let context = managedObjectContext()
        
        do {
            
            try context.save()
            
        } catch {
            
            print("Error saving HackathonItemConext - \(error)")
        }
    }
}
