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
    @IBOutlet var labelsView: UIView!
    
    var delegate: HCHackathonTableViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        mapView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: Selector("performTransition:")))
        
        // Creating a blur effect with dark style
        let blurEffect = UIBlurEffect(style: .Dark)
        // Creating a view for the blur effect with the same size of labels view
        let blurView = UIVisualEffectView(frame: labelsView.frame)
        // Add effect for the blur view
        blurView.effect = blurEffect
        
        // Insert the blur layer below our existing labels
        self.contentView.insertSubview(blurView, belowSubview: labelsView)
    }
    
    func performTransition(gesture: UITapGestureRecognizer) {
        
        delegate?.performSegueOnMapClick(tag)
    }
    
    /**
        Modified the function signature to take a latitude and a longitude, instead of
        a CLLocationCoordinate2D object, because our HackathonItem has those two attributes. 
        They can be also nil, if that's the case we won't animate the map to that location.
    */
    func addLocation(latitude: Double?, longitude: Double?) {
        
        if let l1 = latitude, l2 = longitude {
            
            let region = MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2D(latitude: l1, longitude: l2), 5000, 5000)
            mapView.setRegion(region, animated: true)
        }
    }
}
