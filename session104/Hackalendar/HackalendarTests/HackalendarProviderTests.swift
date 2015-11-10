//
//  HackalendarProviderTests.swift
//  Hackalendar
//
//  Created by Alex Telek on 08/11/2015.
//  Copyright © 2015 Alex Telek. All rights reserved.
//

import XCTest
@testable import Hackalendar

class HackalendarProviderTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testHackathonProviderReturnHackathonObjectAfterSuccessfulParse() {
        
        let expectations = expectationWithDescription("Expect to return Hackathon object from Server after GET call has been created")
        
        let hackkings = HTLHackathon(title: "HackKings")
        hackkings.startDate = "December 12"
        hackkings.city = "London, United Kingdom"
        
        HTLHackathonProvider.provideHackathonsFor(12) { (hackathons) -> Void in
            
            expectations.fulfill()
            
            XCTAssertEqual(hackathons.count, 2)
            XCTAssertEqual(hackathons.first!.title, hackkings.title)
            XCTAssertEqual(hackathons.first!.startDate, hackkings.startDate)
            XCTAssertEqual(hackathons.first!.city, hackkings.city)
        }
        
        waitForExpectationsWithTimeout(10.0) { (error) -> Void in
            
            print("Expectations has timed out with error: \(error) - no data")
        }
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            
            HTLHackathonProvider.provideHackathonsFor(12, block: { (hackathons) -> Void in })
        }
    }
    
}
