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
        
        XCTAssertEqual(HTLLocationUtility.extractCityFromLocation(validLocation), "London")
    }
    
    func testCityExtractedFromStringWhenInvalidLocationIsPassed() {
        
        XCTAssertEqual(HTLLocationUtility.extractCityFromLocation(invalidLocation), invalidLocation)
    }
    
    func testGeolocateCityFromLocationNameWhenValidLocationIsPassed() {
    
        let expectations = expectationWithDescription("Excpect to return a valid location coordinates based on the string provided")
        
        HTLLocationUtility.geolocateCityForLocationName(validLocation) { (coordinate) -> Void in
            
            expectations.fulfill()
            
            XCTAssertNotNil(coordinate)
        }
        
        waitForExpectationsWithTimeout(5.0) { (error) -> Void in
            
            print("Error occured while exctracting location from string: \(error)")
            
        }
    }
    
    func testGeolocateCityFromLocationNameWhenInvalidLocationIsPassed() {
        
        let expectations = expectationWithDescription("Excpect to return no location coordinates based on the invalid string provided")
        
        HTLLocationUtility.geolocateCityForLocationName(invalidLocationOnMap) { (coordinate) -> Void in
            
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
        
            HTLLocationUtility.extractCityFromLocation(self.validLocation)
        }
    }
    
    func testPerformanceOfLocalSearch() {
        // This is an example of a performance test case.
        self.measureBlock {
            
            HTLLocationUtility.geolocateCityForLocationName(self.validLocation, completitionHandler: { (coordinate) -> Void in })
        }
    }
    
}
