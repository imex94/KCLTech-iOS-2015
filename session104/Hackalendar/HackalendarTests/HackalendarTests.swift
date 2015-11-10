//
//  HackalendarTests.swift
//  HackalendarTests
//
//  Created by Alex Telek on 03/11/2015.
//  Copyright © 2015 Alex Telek. All rights reserved.
//

import XCTest
@testable import Hackalendar

class HackalendarTests: XCTestCase {
    
    let validURL = "http://www.hackalist.org/api/1.0/2015/12.json"
    let notValidURL = "http://www.hackalist.org/api/1.0/2016/12.json"
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testServerGETMethodFetchDataIfURLIsValid() {
    
        let expectations = expectationWithDescription("Expect to fetch data from Server after GET call has been created")
        
        let server = HTLServer.sharedServer()

        server.GET(validURL) { (serverResponse) -> Void in
            
            expectations.fulfill()
            
            switch serverResponse {
                case .Success(let data): XCTAssertNotNil(data, "Fetched data from Server is Nil")
                case _: XCTAssertTrue(false)
            }
        }
        
        waitForExpectationsWithTimeout(10.0) { (error) -> Void in
            
            print("Expectations has timed out with error: \(error) - no data")
        }
    }
    
    func testServerGETMethodReturnsServerErrorIfURLIsNotValid() {
        
        let expectations = expectationWithDescription("Expect to return error from Server after GET call has been created with an invalid URL")
        
        let server = HTLServer.sharedServer()
        
        server.GET(notValidURL) { (serverResponse) -> Void in
            
            expectations.fulfill()
            
            switch serverResponse {
                case .Success(let data): XCTAssertNotNil(data, "Fetched data from Server is Nil")
                case .Failure(let errorType): XCTAssertTrue(errorType == .ParseError)
            }
        }
        
        waitForExpectationsWithTimeout(10.0) { (error) -> Void in
            
            print("Expectations has timed out with error: \(error) - no data")
        }
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        
        self.measureBlock {
            
            HTLServer.sharedServer().GET(self.validURL, completitionHandler: { (response) -> Void in })
        }
    }
    
}
