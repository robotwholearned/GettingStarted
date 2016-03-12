//
//  FoodTrackerTests.swift
//  FoodTrackerTests
//
//  Created by Sandquist, Cassandra - Cassandra on 3/12/16.
//  Copyright © 2016 robotwholearned. All rights reserved.
//

import XCTest
@testable import FoodTracker

class FoodTrackerTests: XCTestCase {

    // MARK: FoodTracker Tests

    // Tests to confirm that the Meal initializer returns when no name or a negative rating is provided.
    func testMealInitializationFailsWithInvalidInput() {
        let potentialItem = Meal(name: "", photo: nil, rating: 0)
        XCTAssertNil(potentialItem, "Empty name is invalid")
    }

    func testMealInitializationSuccedsWithValidInput() {
        let potentialItem = Meal(name: "Newest meal", photo: nil, rating: 5)
        XCTAssertNotNil(potentialItem)
    }

    func testMealInitializationSuccedsWithInvalidInput() {
        let badRating = Meal(name: "Really bad rating", photo: nil, rating: -1)
        XCTAssertNotNil(badRating)
    }
}
