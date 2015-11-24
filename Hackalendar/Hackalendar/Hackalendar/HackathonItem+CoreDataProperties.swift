//
//  HackathonItem+CoreDataProperties.swift
//  Hackalendar
//
//  Created by Clarence Ji on 11/24/15.
//  Copyright © 2015 Alex Telek. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension HackathonItem {

    @NSManaged var city: String?
    @NSManaged var endDate: String?
    @NSManaged var facebookURL: String?
    @NSManaged var googlePlusURL: String?
    @NSManaged var highSchoolers: NSNumber?
    @NSManaged var host: String?
    @NSManaged var latitude: NSNumber?
    @NSManaged var length: NSNumber?
    @NSManaged var longitude: NSNumber?
    @NSManaged var month: NSNumber?
    @NSManaged var notes: String?
    @NSManaged var prize: NSNumber?
    @NSManaged var size: String?
    @NSManaged var startDate: String?
    @NSManaged var title: String?
    @NSManaged var travel: String?
    @NSManaged var twitterURL: String?
    @NSManaged var url: String?
    @NSManaged var year: NSNumber?

}
