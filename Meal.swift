//
//  Meal.swift
//  FoodTracker
//
//  Created by Sandquist, Cassandra - Cassandra on 3/12/16.
//  Copyright © 2016 robotwholearned. All rights reserved.
//

import UIKit

class Meal: NSObject, NSCoding {

    // MARK: Properties
    var name: String
    var photo: UIImage?
    var rating: Int
    var instructions: [String]?
    var ingredients: [String]?

    // MARK: Archiving Paths
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("meals")

    // MARK: Types
    struct PropertyKey {
        static let nameKey = "name"
        static let photoKey = "photo"
        static let ratingKey = "rating"
        static let instructionsKey = "instructions"
        static let ingredientsKey = "ingredients"
    }

    // MARK: Initialization
    init?(name: String, photo: UIImage?, rating: Int, ingredients: [String]?, instructions: [String]?) {

        // Initialize stored properties.
        self.name = name
        self.photo = photo
        self.rating = rating
        self.ingredients = ingredients
        self.instructions = instructions

        super.init()

        // Initialization should fail if there is no name or if the rating is negative.
        if name.isEmpty || rating < 0 {
            return nil
        }
    }

    // MARK: NSCoding
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: PropertyKey.nameKey)
        aCoder.encodeObject(photo, forKey: PropertyKey.photoKey)
        aCoder.encodeInteger(rating, forKey: PropertyKey.ratingKey)
        aCoder.encodeObject(ingredients, forKey: PropertyKey.ingredientsKey)
        aCoder.encodeObject(instructions, forKey: PropertyKey.instructionsKey)
    }
    required convenience init?(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObjectForKey(PropertyKey.nameKey) as! String
        let photo = aDecoder.decodeObjectForKey(PropertyKey.photoKey) as? UIImage
        let rating = aDecoder.decodeIntegerForKey(PropertyKey.ratingKey)
        let ingredients = aDecoder.decodeObjectForKey(PropertyKey.ingredientsKey) as? [String]
        let instructions = aDecoder.decodeObjectForKey(PropertyKey.instructionsKey) as? [String]

        self.init(name: name, photo: photo, rating: rating, ingredients: ingredients, instructions: instructions)

    }
}
