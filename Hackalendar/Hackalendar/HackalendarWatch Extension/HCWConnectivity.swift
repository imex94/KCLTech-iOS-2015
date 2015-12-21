//
//  HCWConnectivity.swift
//  Hackalendar
//
//  Created by Alex Telek on 08/12/2015.
//  Copyright © 2015 Alex Telek. All rights reserved.
//

import WatchKit
import WatchConnectivity

class HCWConnectivity: NSObject, WCSessionDelegate {

    var session: WCSession?
    
    override init() {
        super.init()
        
        if WCSession.isSupported() {
            session = WCSession.defaultSession()
            session!.delegate = self
            session!.activateSession()
        }
    }
    
    func sendData(block: ([HCWHackathon]) -> Void) {
        
        session?.sendMessage(["reference" : "sending"], replyHandler: { (reply :[String:AnyObject]) -> Void in
            
//            print(reply["reply"]!)
            block(HCWHackathonDeserialization.deserializeObject(reply["reply"]! as! Dictionary<String, AnyObject>))
            
            }, errorHandler: { (error) -> Void in
                
                print(error.description)
        })
    }
}
