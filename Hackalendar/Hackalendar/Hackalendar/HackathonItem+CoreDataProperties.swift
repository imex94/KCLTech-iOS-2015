//
//  HackathonItem+CoreDataProperties.swift
//  Hackalendar
//
//  Created by Clarence Ji on 11/17/15.
//  Copyright © 2015 Alex Telek. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension HackathonItem {

    @NSManaged var month: Int16
    @NSManaged var year: Int16
    @NSManaged var startDate: String?
    @NSManaged var endDate: String?
    @NSManaged var title: String?
    @NSManaged var url: String?
    @NSManaged var city: String?
    @NSManaged var host: String?
    @NSManaged var length: Int16
    @NSManaged var size: String?
    @NSManaged var travel: String?
    @NSManaged var prize: Bool
    @NSManaged var highSchoolers: Bool
    @NSManaged var facebookURL: String?
    @NSManaged var twitterURL: String?
    @NSManaged var googlePlusURL: String?
    @NSManaged var notes: String?
    @NSManaged var latitude: Double
    @NSManaged var longitude: Double

}
