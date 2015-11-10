//
//  HTLServer.swift
//  Hackalendar
//
//  Created by Alex Telek on 07/11/2015.
//  Copyright © 2015 Alex Telek. All rights reserved.
//

import UIKit

enum HTLServerErrorType {
    case ServerError
    case ParseError
}

enum HTLServerResponse {
    case Failure(HTLServerErrorType)
    case Success(AnyObject?)
}

class HTLServer: NSObject {

    class func sharedServer() -> HTLServer {
        
        var sharedInstance: HTLServer!
        var onceToken = dispatch_once_t()
        
        dispatch_once(&onceToken) { () -> Void in
            sharedInstance = HTLServer()
        }
        
        return sharedInstance
    }
    
    func GET(urlString: String, completitionHandler: (HTLServerResponse) -> Void) {
        
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
