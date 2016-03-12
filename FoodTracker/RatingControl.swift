//
//  RatingControl.swift
//  FoodTracker
//
//  Created by Sandquist, Cassandra - Cassandra on 3/12/16.
//  Copyright © 2016 robotwholearned. All rights reserved.
//

import UIKit

class RatingControl: UIView {

    // MARK: Properties
    var rating = 0
    var ratingButtons = [UIButton]()
    let buttonWidth = 44
    let buttonPadding = 5
    let startingButtonFrame = CGRect(x: 0, y: 0, width: 44, height: 44)

    // MARK: Initialization
    //Every UIView subclass that implements an initializer must include an implementation of init?(coder:)
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        for _ in 0..<5 {
            addButton()
        }
    }

    override func layoutSubviews() {
        var buttonFrame = startingButtonFrame

        for (index, button) in ratingButtons.enumerate() {
            buttonFrame.origin.x = CGFloat(index * (buttonWidth + buttonPadding))
            button.frame = buttonFrame
        }
    }

    func addButton() {

        let button = UIButton(frame: startingButtonFrame)

        button.backgroundColor = .redColor()
        button.addTarget(self, action: "ratingButtonTapped:", forControlEvents: .TouchDown)

        ratingButtons += [button]

        addSubview(button)

    }

    override func intrinsicContentSize() -> CGSize {
        return CGSize(width: 240, height: 44)
    }

    // MARK: Button Action
    func ratingButtonTapped(sender: UIButton) {
        print("Button pressed 👍")
    }

}
