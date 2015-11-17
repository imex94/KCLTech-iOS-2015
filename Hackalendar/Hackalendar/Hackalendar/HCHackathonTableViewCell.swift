//
//  HTLHackathonTableViewCell.swift
//  HackTheList
//
//  Created by Alex Telek on 03/11/2015.
//  Copyright © 2015 Alex Telek. All rights reserved.
//

import UIKit
import MapKit

protocol HCHackathonTableViewDelegate {
    
    func performSegueOnMapClick(index: Int)
}

class HCHackathonTableViewCell: UITableViewCell {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var hackathonName: UILabel!
    @IBOutlet weak var hackathonDate: UILabel!
    @IBOutlet weak var HackathonPlace: UILabel!
    
    var delegate: HCHackathonTableViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        mapView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: Selector("performTransition:")))
    }
    
    func performTransition(gesture: UITapGestureRecognizer) {
        
        delegate?.performSegueOnMapClick(tag)
    }
    
    func addLocation(location: CLLocationCoordinate2D?) {
        
        if let coordinate = location {
            
            let region = MKCoordinateRegionMakeWithDistance(coordinate, 5000, 5000)
            mapView.setRegion(region, animated: true)
        }
    }
}
