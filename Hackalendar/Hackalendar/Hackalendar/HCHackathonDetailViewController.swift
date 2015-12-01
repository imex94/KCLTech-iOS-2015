//
//  HTLHackathonDetailViewController.swift
//  HackTheList
//
//  Created by Alex Telek on 03/11/2015.
//  Copyright © 2015 Alex Telek. All rights reserved.
//

import UIKit

class HCHackathonDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    // Button - facebook - tag: 1
    // Button - twitter - tag: 2
    // Label - November... - tag: 3
    // Label - Hosted by... - tag: 4
    // Label - Capacity... - tag: 5
    // Image - Status - travel reimbursement: 6
    // Image - Status - Prizes: 7
    // Image - Status - High Schoolers: 8
    
    @IBOutlet var tableView: UITableView!
    
    var urlString1 = "http://facebook.com"
    var urlString2 = "http://twitter.com"
    
    var hackathon: HackathonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.estimatedRowHeight = 50
    }
    
    func addLinkToButtons(fbButton: UIButton, _ twitterButton: UIButton) {
        
        fbButton.addTarget(self, action: "openFBURL", forControlEvents: .TouchUpInside)
        twitterButton.addTarget(self, action: "openTwitterURL", forControlEvents: .TouchUpInside)
        
    }
    
    func changeLabelContents(label1: UILabel, _ label2: UILabel, _ label3: UILabel) {
        label1.text = "\(hackathon.startDate!) - \(hackathon.endDate!) in \(hackathon.city!)"
        label2.text = "Hosted by \(hackathon.host!)"
        if hackathon.size != nil {
            label3.text = "Capacity: \(hackathon.size!)"
        }
    }
    
    func changeStatuses(img1: UIImageView, _ img2: UIImageView, _ img3: UIImageView) {
        let isTravelReimburseAvailable = hackathon.travel
        if isTravelReimburseAvailable != nil {
            
            switch isTravelReimburseAvailable! {
                case "yes":
                    img1.image = UIImage(named: "status-yes")
            
                case "unknown":
                    img1.image = UIImage(named: "status-question")
                
                default: break
            }
        }
        
        if let _ = hackathon.prize?.boolValue {
            img2.image = UIImage(named: "status-yes")
        }
        
        if let _ = hackathon.highSchoolers?.boolValue {
            img3.image = UIImage(named: "status-yes")
        }
    }
    
    func openFBURL() {
        if let url = hackathon.facebookURL {
            UIApplication.sharedApplication().openURL(NSURL(string: url)!)
        }
    }
    
    func openTwitterURL() {
        if let url = hackathon.twitterURL {
            UIApplication.sharedApplication().openURL(NSURL(string: url)!)
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellIdentifier = "detailCell\(indexPath.row)"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
        
        switch indexPath.row {
            case 0:
                addLinkToButtons(cell.viewWithTag(1) as! UIButton, cell.viewWithTag(2) as! UIButton)
            case 1:
                changeLabelContents(cell.viewWithTag(3) as! UILabel, cell.viewWithTag(4) as! UILabel, cell.viewWithTag(5) as! UILabel)
            case 2:
                changeStatuses(cell.viewWithTag(6) as! UIImageView, cell.viewWithTag(7) as! UIImageView, cell.viewWithTag(8) as! UIImageView)
            default: break
        }
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}
