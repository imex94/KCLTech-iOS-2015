//
//  ViewController.swift
//  Project2
//
//  Created by Alex Telek on 20/10/2015.
//  Copyright © 2015 King's College London. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func deepLinkButtonPressed(sender: UIButton) {
        
        UIApplication.sharedApplication().openURL(NSURL(string: "project1://")!)
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
}

