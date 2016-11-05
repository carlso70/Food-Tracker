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
        XCTAssertNotNil(test1, "As long as name and rating are good, you can init with nil pic")
        
        let test2 = Meal(name: "Hi", photo: #imageLiteral(resourceName: "emptyStar"), rating: 0)
        XCTAssertNotNil(test2, "Name not nil, and rating > 0 is good")
        
        // Fail cases
        
        let test3 = Meal(name: "", photo: #imageLiteral(resourceName: "emptyStar"), rating: 10)
        XCTAssertNil(test3, "Empty name is bad")
        
        let test4 = Meal(name: "Jimmy", photo: nil, rating: -1)
        XCTAssertNil(test4, "Rating less than 0 is bad")
        
    }
    
}
