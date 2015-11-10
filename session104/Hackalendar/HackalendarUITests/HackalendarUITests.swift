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
    
    func testApplicationFetchesHackathonsWhenAppDidLoad() {
        
        let app = XCUIApplication()
        
        XCTAssertTrue(app.tables.cells.count >= 1)
        XCTAssertTrue(app.navigationBars["Hackathons"].exists)
    }
    
    func testCellsContainMapForEachHackathon() {
    
        let tablesQuery = XCUIApplication().tables
        XCTAssertTrue(tablesQuery.cells.element.maps.element.exists)
    }
    
    func testCellsContainViewWilThreeLables() {
    
        let tableQuery = XCUIApplication().tables
        
        XCTAssertTrue(tableQuery.staticTexts["HackKings"].exists)
        XCTAssertTrue(tableQuery.staticTexts["December 12"].exists)
        XCTAssertTrue(tableQuery.staticTexts["London"].exists)
    }
}
