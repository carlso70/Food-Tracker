//
//  Meal.swift
//  FoodTracker
//
//  Created by James Carlson on 11/4/16.
//  Copyright © 2016 James Carlson. All rights reserved.
//

import UIKit

class Meal: NSObject, NSCoding {
    
    // MARK: Types
    
    struct PropertyKey {
        static let nameKey = "name"
        static let photoKey = "photo"
        static let ratingKey = "rating"
    }
    
    // MARK: Properties
    
    var name: String
    var photo: UIImage?
    var rating: Int
    
    // MARK: Initialization
    
    init?(name: String, photo: UIImage?, rating: Int) {
        self.name = name
        self.photo = photo
        self.rating = rating
        
        super.init()
        
        // Initializer should fail if bad param
        if name.isEmpty || rating < 0 {
            return nil
        }
    }
    
    // MARK: NSConfig
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.nameKey)
        aCoder.encode(photo, forKey: PropertyKey.photoKey)
        aCoder.encode(rating, forKey: PropertyKey.ratingKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObject(forKey: PropertyKey.nameKey) as! String
        let photo = aDecoder.decodeObject(forKey: PropertyKey.photoKey) as? UIImage
        let rating = aDecoder.decodeInteger(forKey: PropertyKey.ratingKey)
        
        // Must call designated initializer
        
        self.init(name: name, photo: photo, rating:rating)
    }
    
    // MARK: Archiving Paths
    
    static let documentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let archiveURL = documentsDirectory.appendingPathComponent("meals")
}
