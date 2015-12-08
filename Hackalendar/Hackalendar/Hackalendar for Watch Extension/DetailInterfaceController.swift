//
//  DetailInterfaceController.swift
//  Hackalendar
//
//  Created by Alex Telek on 08/12/2015.
//  Copyright © 2015 Alex Telek. All rights reserved.
//

import WatchKit
import HackalendarWatchSDK

class DetailInterfaceController: WKInterfaceController {

    var hackathon: HSHackathonObject!
    
    @IBOutlet var hackathonMap: WKInterfaceMap!
    
    @IBOutlet var travelImage: WKInterfaceImage!
    @IBOutlet var prizeImage: WKInterfaceImage!
    @IBOutlet var highSchoolImage: WKInterfaceImage!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        if let hackathon = context as? HSHackathonObject {
            self.hackathon = hackathon
        }
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        setImages()
    }
    
    func setImages() {
        
        let isTravelReimbursementAvaiable = hackathon.travel
        if let _ = isTravelReimbursementAvaiable {
            switch isTravelReimbursementAvaiable! {
            case "yes":
                travelImage.setImage(UIImage(named: "status-yes"))
            case "no":
                travelImage.setImage(UIImage(named: "status-no"))
            default: break
            }
        }
        
        let isPrizeAvaiable = hackathon.prize?.boolValue
        switch isPrizeAvaiable! {
        case true:
            prizeImage.setImage(UIImage(named: "status-yes"))
        case false:
            prizeImage.setImage(UIImage(named: "status-no"))
        }
        
        let isHighschoolersAllowed = hackathon.highSchoolers?.boolValue
        switch isHighschoolersAllowed! {
        case true:
            highSchoolImage.setImage(UIImage(named: "status-yes"))
        case false:
            highSchoolImage.setImage(UIImage(named: "status-no"))
        }
    }
}
