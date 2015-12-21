//
//  InterfaceController.swift
//  HackalendarWatch Extension
//
//  Created by Alex Telek on 08/12/2015.
//  Copyright © 2015 Alex Telek. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    @IBOutlet var tableView: WKInterfaceTable!
    
    private var hackathons = [HCWHackathon]()
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        let connectivity = HCWConnectivity()
        connectivity.sendData { (hackathons) -> Void in
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                
                self.hackathons = hackathons
                self.setupTable()
            })
        }
    }

    func setupTable() {
        
        tableView.setRowTypes(Array(count: hackathons.count, repeatedValue: "HCWHackathonRow"))
        
        for var i = 0; i < tableView.numberOfRows; i++ {
            let row: AnyObject? = tableView.rowControllerAtIndex(i)
            let hackathon = hackathons[i]

            let hackathonRow = row as! HCWHackathonRow
            hackathonRow.hackathonName.setText(hackathon.title)
            hackathonRow.hackathonPlace.setText(extractCityNameFromLocation(hackathon.city))
        }
    }
    
    func extractCityNameFromLocation(location: String?) -> String? {
        
        if location == nil {
            return ""
        }
        
        return location!.characters.split{$0 == ","}.map(String.init).first
    }
    
    override func table(table: WKInterfaceTable, didSelectRowAtIndex rowIndex: Int) {
        pushControllerWithName("hackathonDetail", context: hackathons[rowIndex])
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
