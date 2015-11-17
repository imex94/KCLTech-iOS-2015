//
//  HCHackathonProviderTest.swift
//  Hackalendar
//
//  Created by Clarence Ji on 11/17/15.
//  Copyright © 2015 Alex Telek. All rights reserved.
//

import XCTest
@testable import Hackalendar

class HCHackathonProviderTest: XCTestCase {

    let validURL = "http://www.hackalist.org/api/1.0/2015/12.json"
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testProviderReturnsHackathonObject() {
        
        let expectation = expectationWithDescription("Provider parse Hackathon objects")
        
        let hackkings = HCHackathon(title: "HackKings")
        hackkings.startDate = "December 12"
        hackkings.city = "London, United Kingdom"
        
        HCHackathonProvider.provideHackathonsFor(12) { (hackathons) -> Void in
            
            expectation.fulfill()
            
            XCTAssertEqual(hackathons.count, 2)
            XCTAssertEqual(hackathons.first!.title, hackkings.title)
            XCTAssertEqual(hackathons.first!.startDate, hackkings.startDate)
            XCTAssertEqual(hackathons.first!.city, hackkings.city)
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
