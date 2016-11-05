//
//  FoodTrackerTests.swift
//  FoodTrackerTests
//
//  Created by James Carlson on 11/2/16.
//  Copyright © 2016 James Carlson. All rights reserved.
//

import XCTest
@testable import FoodTracker

class FoodTrackerTests: XCTestCase {
    
    // MARK: Food tracker tests
    
    // Test that the Meal initialization works correctly
    // Should return nil with empty name or negative rating
    
    func testMealInitialization() {
        // Success cases
        
        let test1 = Meal(name: "test", photo: nil, rating: 5)
        XCTAssertNotNil(test1)
        
        let test2 = Meal(name: "Hi", photo: #imageLiteral(resourceName: "emptyStar"), rating: 0)
        XCTAssertNotNil(test2)
        
        // Fail cases
        
        let test3 = Meal(name: "", photo: #imageLiteral(resourceName: "emptyStar"), rating: 10)
        XCTAssertNil(test3)
        
        let test4 = Meal(name: "Jimmy", photo: nil, rating: -1)
        XCTAssertNil(test4)
        
    }
    
}
