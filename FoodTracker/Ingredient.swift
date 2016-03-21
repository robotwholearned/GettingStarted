//
//  Ingredient.swift
//  FoodTracker
//
//  Created by Sandquist, Cassandra - Cassandra on 3/20/16.
//  Copyright © 2016 robotwholearned. All rights reserved.
//

import UIKit

class Ingredient: NSObject {
    // MARK: Properties
    var quantity: Float
    var measurement: String?
    var rawIngredient: String

    // MARK: Initialization
    init?(raw: String, measurement: String?, quantity: Float) {
        self.rawIngredient = raw
        self.measurement = measurement
        self.quantity = quantity

        super.init()

        if rawIngredient.isEmpty {
            return nil
        }
    }
}
