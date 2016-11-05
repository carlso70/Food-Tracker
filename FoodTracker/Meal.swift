//
//  Meal.swift
//  FoodTracker
//
//  Created by James Carlson on 11/4/16.
//  Copyright © 2016 James Carlson. All rights reserved.
//

import UIKit

class Meal {
    
    // MARK: Properties
    
    var name: String
    var photo: UIImage?
    var rating: Int
 
    // MARK: Initialization
    
    init?(name: String, photo: UIImage?, rating: Int) {
        self.name = name
        self.photo = photo
        self.rating = rating
        
        // Initializer should fail if bad param
        if name.isEmpty || rating < 0 {
            return nil
        }
    }
    
}
