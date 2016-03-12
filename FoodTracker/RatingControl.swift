//
//  RatingControl.swift
//  FoodTracker
//
//  Created by Sandquist, Cassandra - Cassandra on 3/12/16.
//  Copyright © 2016 robotwholearned. All rights reserved.
//

import UIKit

class RatingControl: UIView {

    // MARK: Initialization
    //Every UIView subclass that implements an initializer must include an implementation of init?(coder:)
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        button.backgroundColor = .redColor()

        addSubview(button)
    }

}
