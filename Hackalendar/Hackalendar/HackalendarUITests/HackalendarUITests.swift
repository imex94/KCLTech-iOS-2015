//
//  HackalendarUITests.swift
//  HackalendarUITests
//
//  Created by Alex Telek on 03/11/2015.
//  Copyright © 2015 Alex Telek. All rights reserved.
//

import XCTest

class HackalendarUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testTitleHasIncludedOnNavigationBarWhenViewDidLoad() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        
        
        // There are many methods and attributes you can use for testing, you can get buttons, labels on view
        // For our app we needed the navigation bar. If you don't know how to get that, press record and click on the navigation bar
        // It will give you do code for it and you can modify it according to this:
        
        // XCTAsstert class will make sure that the line we have down there is compared to something. In this case
        // we compare if the navigation bar exists or not to true. If true = true -> pass otherwise fail
        
        XCTAssertTrue(XCUIApplication().navigationBars["Hackathons"].exists)
    }
    
    func testCellsContainMapForEachHackathon() {
        
        let query = XCUIApplication().tables
        XCTAssertTrue(query.cells.element.maps.element.exists)
    }
    
    func testCellsContainThreeLables() {
        
        let query = XCUIApplication().tables
        
        XCTAssertTrue(query.staticTexts["Citrus Hack"].exists)
        XCTAssertTrue(query.staticTexts["November 6"].exists)
    }
}
