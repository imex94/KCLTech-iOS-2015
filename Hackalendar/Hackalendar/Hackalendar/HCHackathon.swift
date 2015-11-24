//
//  HTLHackathon.swift
//  HackTheList
//
//  Created by Alex Telek on 03/11/2015.
//  Copyright © 2015 Alex Telek. All rights reserved.
//

import UIKit
import CoreLocation

class HCHackathon {
    
    var title: String?
    var url: NSURL?
    var startDate: String?
    var endDate: String?
    var year: Int!
    var city: String?
    var host: String?
    var length: Int!
    var size: Int!
    var travel: Bool?
    var prize: Bool!
    var highSchoolers: Bool!
    var facebookURL: NSURL?
    var twitterURL: NSURL?
    var googlePlusURL: NSURL?
    var notes: String?
    
    var coordinate: CLLocationCoordinate2D?
    
    init(title: String?) {
        self.title = title
    }
}