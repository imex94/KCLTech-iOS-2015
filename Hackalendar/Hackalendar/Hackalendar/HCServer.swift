//
//  HCServer.swift
//  Hackalendar
//
//  Created by Alex Telek on 10/11/2015.
//  Copyright © 2015 Alex Telek. All rights reserved.
//

import UIKit

enum HCServerError {
    case ServerError
    case ParseError
}

enum HCServerResponse {
    case Success(AnyObject?)
    case Failure(HCServerError)
}

class HCServer: NSObject {

    class func sharedServer() -> HCServer {
        
        var sharedInstance: HCServer!
        var onceToken = dispatch_once_t()
        
        dispatch_once(&onceToken) { () -> Void in
            sharedInstance = HCServer()
        }
        
        return sharedInstance
    }
    
    func GET(urlString: String, completitionHandler: (HCServerResponse) -> Void) {
     
        let session = NSURLSession.sharedSession()
        let dataTask = session.dataTaskWithURL(NSURL(string: urlString)!) { (data, response, error) -> Void in
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                
                if data == nil {
                    
                    completitionHandler(.Failure(.ServerError))
                    return
                }
                
                do {
                    
                    let json = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments)
                    completitionHandler(.Success(json))
                    
                } catch {
                    
                    completitionHandler(.Failure(.ParseError))
                }
            })
        }
        dataTask.resume()
    }
}
