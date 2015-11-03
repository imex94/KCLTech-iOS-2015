//
//  HTLHackathonTableViewCell.swift
//  HackTheList
//
//  Created by Alex Telek on 03/11/2015.
//  Copyright © 2015 Alex Telek. All rights reserved.
//

import UIKit
import MapKit

protocol HTLHackathonTableViewDelegate {
    
    func performSegueOnMapClick(index: Int)
}

class HTLHackathonTableViewCell: UITableViewCell {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var hackathonName: UILabel!
    @IBOutlet weak var hackathonDate: UILabel!
    @IBOutlet weak var HackathonPlace: UILabel!
    
    var delegate: HTLHackathonTableViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        mapView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: Selector("performTransition:")))
    }
    
    func performTransition(gesture: UITapGestureRecognizer) {
        
        delegate?.performSegueOnMapClick(tag)
    }
}
