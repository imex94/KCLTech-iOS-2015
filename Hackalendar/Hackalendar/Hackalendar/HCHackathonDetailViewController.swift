//
//  HTLHackathonDetailViewController.swift
//  HackTheList
//
//  Created by Alex Telek on 03/11/2015.
//  Copyright © 2015 Alex Telek. All rights reserved.
//

import UIKit

class HCHackathonDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    
    var hackathon: HackathonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // Option-click "estimatedRowHeight" for info
        // This helps tableview cells resize themselves
        tableView.estimatedRowHeight = 50
    }
    
    /////
    // MARK: - TableView Data Source
    /////
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // Cell identifiers set in storyboard with index (detailCell0, detailCell1, detailCell2)
        let cellIdentifier = "detailCell\(indexPath.row)"
        // Get that cell from the storyboard for reusing
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
        
        // Populate cells with data
        switch indexPath.row {
            
            case 0:
                addLinkToButtons(cell.viewWithTag(1) as! UIButton, cell.viewWithTag(2) as! UIButton)
            
            case 1:
                changeLabelContents(cell.viewWithTag(3) as! UILabel, cell.viewWithTag(4) as! UILabel, cell.viewWithTag(5) as! UILabel)
            
            case 2:
                changeStatuses(cell.viewWithTag(6) as! UIImageView, cell.viewWithTag(8) as! UIImageView, cell.viewWithTag(10) as! UIImageView)
            
            default: break
            
        }
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Number of Rows
        return 3
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Number of Sections
        return 1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        // Dynamic Row Height
        return UITableViewAutomaticDimension
    }
    
    /////
    // MARK: - Functional Methods
    /////
    
    /// Add event listeners to buttons for opening webpages in Safari.
    func addLinkToButtons(fbButton: UIButton, _ twitterButton: UIButton) {
        
        fbButton.addTarget(self, action: "openFBURL", forControlEvents: .TouchUpInside)
        twitterButton.addTarget(self, action: "openTwitterURL", forControlEvents: .TouchUpInside)
        
    }
    
    /// Open Facebook page in Safari.
    func openFBURL() {
        if let url = hackathon.facebookURL {
            UIApplication.sharedApplication().openURL(NSURL(string: url)!)
        }
    }
    
    /// Open Twitter profile page in Safari
    func openTwitterURL() {
        if let url = hackathon.twitterURL {
            UIApplication.sharedApplication().openURL(NSURL(string: url)!)
        }
    }
    
    /// Change the placeholder to actual information.
    /// - parameters:
    ///     - label1: The label showing when and where the hackathon will be held.
    ///     - label2: The label showing the organizer.
    ///     - label3: The label showing the capacity. Note: capacity can be nil.
    func changeLabelContents(label1: UILabel, _ label2: UILabel, _ label3: UILabel) {
        label1.text = "\(hackathon.startDate!) - \(hackathon.endDate!) in \(hackathon.city!)"
        label2.text = "Hosted by \(hackathon.host!)"
        if hackathon.size != nil {
            label3.text = "Capacity: \(hackathon.size!)"
        }
    }
    
    /// Change the icons.
    /// - parameters:
    ///     - img1: Travel reimbursement
    ///     - img2: Prizes
    ///     - img3: High schoolers
    func changeStatuses(img1: UIImageView, _ img2: UIImageView, _ img3: UIImageView) {
        
        let isTravelReimbursementAvaiable = hackathon.travel
        if let _ = isTravelReimbursementAvaiable {
            switch isTravelReimbursementAvaiable! {
            case "yes":
                img1.image = UIImage(named: "status-yes")
            case "no":
                img1.image = UIImage(named: "status-no")
            default: break
            }
        }
        
        let isPrizeAvaiable = hackathon.prize?.boolValue
        switch isPrizeAvaiable! {
        case true:
            img2.image = UIImage(named: "status-yes")
        case false:
            img2.image = UIImage(named: "status-no")
        }
        
        let isHighschoolersAllowed = hackathon.highSchoolers?.boolValue
        switch isHighschoolersAllowed! {
        case true:
            img3.image = UIImage(named: "status-yes")
        case false:
            img3.image = UIImage(named: "status-no")
        }
        
    }
    

}
