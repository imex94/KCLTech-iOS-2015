//
//  HackalendarLocationUtilityTests.swift
//  Hackalendar
//
//  Created by Alex Telek on 08/11/2015.
//  Copyright © 2015 Alex Telek. All rights reserved.
//

import XCTest
@testable import Hackalendar

class HackalendarLocationUtilityTests: XCTestCase {
    
    let validLocation = "London, United Kingdom"
    let invalidLocation = "Los Angeles - CA - United States"
    
    let invalidLocationOnMap = "KCLTech Society"
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCityExtractedFromStringWhenValidLocationIsPassed() {
        
        XCTAssertEqual(HCLocationUtility.extractCityNameFromLocation(validLocation), "London")
    }
    
    func testCityExtractedFromStringWhenInvalidLocationIsPassed() {
        
        XCTAssertEqual(HCLocationUtility.extractCityNameFromLocation(invalidLocation), invalidLocation)
    }
    
    func testGeolocateCityFromLocationNameWhenValidLocationIsPassed() {
    
        let expectations = expectationWithDescription("Excpect to return a valid location coordinates based on the string provided")
        
        HCLocationUtility.locateCityForLocationName(validLocation) { (coordinate) -> Void in
            
            expectations.fulfill()
            
            XCTAssertNotNil(coordinate)
        }
        
        waitForExpectationsWithTimeout(5.0) { (error) -> Void in
            
            print("Error occured while exctracting location from string: \(error)")
            
        }
    }
    
    func testGeolocateCityFromLocationNameWhenInvalidLocationIsPassed() {
        
        let expectations = expectationWithDescription("Excpect to return no location coordinates based on the invalid string provided")
        
        HCLocationUtility.locateCityForLocationName(invalidLocationOnMap) { (coordinate) -> Void in
            
            expectations.fulfill()
            
            XCTAssertNil(coordinate)
        }
        
        waitForExpectationsWithTimeout(5.0) { (error) -> Void in
            
            print("Error occured while exctracting location from string: \(error)")
            
        }
    }
    
    func testPerformanceOfLocationExtractor() {
        // This is an example of a performance test case.
        self.measureBlock {
        
            HCLocationUtility.extractCityNameFromLocation(self.validLocation)
        }
    }
    
    func testPerformanceOfLocalSearch() {
        // This is an example of a performance test case.
        self.measureBlock {
            
            HCLocationUtility.locateCityForLocationName(self.validLocation, completitionHandler: { (coordinate) -> Void in })
        }
    }
    
}
