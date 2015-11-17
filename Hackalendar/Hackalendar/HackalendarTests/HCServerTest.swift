//
//  HCServerTest.swift
//  Hackalendar
//
//  Created by Clarence Ji on 11/17/15.
//  Copyright © 2015 Alex Telek. All rights reserved.
//

import XCTest
@testable import Hackalendar

class HCServerTest: XCTestCase {

    let validURL = "http://www.hackalist.org/api/1.0/2015/12.json"
    let inValidURL = "http://www.hackalist.org/api/1.0/2016/12.json"
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testServerGETMethodFetchDataIfURLIsValid() {
        
        let expectation = expectationWithDescription("Fetch Data from internet with valid URL")
        
        HCServer.sharedServer().GET(validURL) { (response) -> Void in
            
            expectation.fulfill()
            
            switch response {
                case .Success(let data): XCTAssertNotNil(data)
                case _: XCTAssertTrue(false)
            }
        }
        
        waitForExpectationsWithTimeout(10.0) { (error) -> Void in
            print(error)
        }
    }
    
    func testServerGETMethodFetchDataIfURLIsInValid() {
        
        let expectation = expectationWithDescription("Fetch Data from internet with invalid URL")
        
        HCServer.sharedServer().GET(inValidURL) { (response) -> Void in
            
            expectation.fulfill()
            
            switch response {
                case .Success(let data): XCTAssertNotNil(data)
                case .Failure(let error): XCTAssertTrue(error == .ParseError)
            }
        }
        
        waitForExpectationsWithTimeout(10.0) { (error) -> Void in
            print(error)
        }
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }

}
