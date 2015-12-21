//
//  HackathonDetailInterfaceController.swift
//  Hackalendar
//
//  Created by Alex Telek on 21/12/2015.
//  Copyright © 2015 Alex Telek. All rights reserved.
//

import WatchKit
import Foundation

class HackathonDetailInterfaceController: WKInterfaceController {

    @IBOutlet var imgTravel: WKInterfaceImage!
    @IBOutlet var imgPrize: WKInterfaceImage!
    @IBOutlet var imgHighSchool: WKInterfaceImage!
    
    private var hackathon: HCWHackathon?
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
        hackathon = context as? HCWHackathon
        changeStatuses(imgTravel, imgPrize, imgHighSchool)
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    /// Change the icons.
    /// - parameters:
    ///     - img1: Travel reimbursement
    ///     - img2: Prizes
    ///     - img3: High schoolers
    func changeStatuses(img1: WKInterfaceImage, _ img2: WKInterfaceImage, _ img3: WKInterfaceImage) {
        
        let isTravelReimbursementAvaiable = hackathon!.travel
        if let _ = isTravelReimbursementAvaiable {
            switch isTravelReimbursementAvaiable! {
            case "yes":
                img1.setImage(UIImage(named: "status-yes"))
            case "no":
                img1.setImage(UIImage(named: "status-no"))
            default: break
            }
        }
        
        let isPrizeAvaiable = hackathon!.prize?.boolValue
        switch isPrizeAvaiable! {
        case true:
            img2.setImage(UIImage(named: "status-yes"))
        case false:
            img2.setImage(UIImage(named: "status-no"))
        }
        
        let isHighschoolersAllowed = hackathon!.highSchoolers?.boolValue
        switch isHighschoolersAllowed! {
        case true:
            img3.setImage(UIImage(named: "status-yes"))
        case false:
            img3.setImage(UIImage(named: "status-no"))
        }
        
    }
}
