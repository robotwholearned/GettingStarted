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
    var stars = 5
    var spacing = 5
    var filledStarImage: UIImage
    var emptyStarImage: UIImage

    // MARK: Initialization
    //Every UIView subclass that implements an initializer must include an implementation of init?(coder:)
    required init?(coder aDecoder: NSCoder) {

        filledStarImage = R.image.filledStar()!
        emptyStarImage = R.image.emptyStar()!

        super.init(coder: aDecoder)

        for _ in 0..<5 {
            addButton()
        }
    }

    override func layoutSubviews() {
        let buttonSize = Int(frame.size.height)
        var buttonFrame = CGRect(x: 0, y: 0, width: buttonSize, height: buttonSize)

        for (index, button) in ratingButtons.enumerate() {
            buttonFrame.origin.x = CGFloat(index * (buttonSize + 5))
            button.frame = buttonFrame
        }
    }

    func addButton() {

        let button = UIButton()

        button.setImage(filledStarImage, forState: .Selected)
        button.setImage(filledStarImage, forState: [.Highlighted, .Selected])
        button.setImage(emptyStarImage, forState: .Normal)

        button.adjustsImageWhenHighlighted = false

        button.addTarget(self, action: "ratingButtonTapped:", forControlEvents: .TouchDown)

        ratingButtons += [button]

        addSubview(button)

    }

    override func intrinsicContentSize() -> CGSize {

        let buttonSize = Int(frame.size.height)
        let width = (buttonSize + spacing) * stars
        return CGSize(width: width, height: buttonSize)
    }

    // MARK: Button Action
    func ratingButtonTapped(sender: UIButton) {
        print("Button pressed 👍")

        rating = ratingButtons.indexOf(sender)! + 1
    }

    func updateButtonSelectionStates() {

    }

}
