//
//  HSHackathon+CoreDataProperties.swift
//  Hackalendar
//
//  Created by Alex Telek on 08/12/2015.
//  Copyright © 2015 Alex Telek. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

public extension HSHackathon {

    @NSManaged public var city: String?
    @NSManaged public var endDate: String?
    @NSManaged public var facebookURL: String?
    @NSManaged public var googlePlusURL: String?
    @NSManaged public var highSchoolers: NSNumber?
    @NSManaged public var host: String?
    @NSManaged public var latitude: NSNumber?
    @NSManaged public var longitude: NSNumber?
    @NSManaged public var length: NSNumber?
    @NSManaged public var month: NSNumber?
    @NSManaged public var notes: String?
    @NSManaged public var prize: NSNumber?
    @NSManaged public var size: String?
    @NSManaged public var startDate: String?
    @NSManaged public var title: String?
    @NSManaged public var travel: String?
    @NSManaged public var twitterURL: String?
    @NSManaged public var url: String?
    @NSManaged public var year: NSNumber?
}
