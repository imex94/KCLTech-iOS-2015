//
//  PRImageViewController.swift
//  Project2
//
//  Created by Alex Telek on 20/10/2015.
//  Copyright © 2015 King's College London. All rights reserved.
//

import UIKit

class PRImageViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        imageView.image = UIImage(named: "london")
    }
    
    
    @IBAction func dismissView(sender: UIButton) {
        
        dismissViewControllerAnimated(true, completion: nil)
    }
}
