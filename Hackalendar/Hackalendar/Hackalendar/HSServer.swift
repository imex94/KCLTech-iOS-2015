//
//  HSServer.swift
//  Hackalendar
//
//  Created by Alex Telek on 10/11/2015.
//  Copyright © 2015 Alex Telek. All rights reserved.
//

import UIKit

enum HSServerError {
    case ServerError
    case ParseError
}

enum HSServerResponse {
    case Success(AnyObject?)
    case Failure(HSServerError)
}

class HSServer: NSObject {

    class func sharedServer() -> HSServer {
        
        var sharedInstance: HSServer!
        var onceToken = dispatch_once_t()
        
        dispatch_once(&onceToken) { () -> Void in
            sharedInstance = HSServer()
        }
        
        return sharedInstance
    }
    
    func GET(urlString: String, completitionHandler: (HSServerResponse) -> Void) {
     
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
