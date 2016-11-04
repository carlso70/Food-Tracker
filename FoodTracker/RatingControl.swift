//
//  RatingControl.swift
//  FoodTracker
//
//  Created by James Carlson on 11/3/16.
//  Copyright © 2016 James Carlson. All rights reserved.
//

import UIKit

class RatingControl: UIView {
    
    // MARK: Properties
    
    let spacing = 5
    let starCount = 5
    let padding = 5
    var rating = 0
    var ratingButtons = [UIButton]()

    // MARK: Initialization
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
 
        for _ in 0 ..< starCount {
            let button = UIButton()
            button.backgroundColor = UIColor.red
            button.addTarget(self, action: #selector(RatingControl.ratingButtonTapped(button:)), for: .touchDown)
            ratingButtons.append(button)
            addSubview(button)
        }
    }
    
    override func layoutSubviews() {
        // Make the button size a of a sqaure that is the frame's height
        let buttonSize = Int(frame.size.height)
        var buttonFrame = CGRect(x: 0, y: 0, width: buttonSize, height: buttonSize)
            
        // Offset each buttons origin by the length of the button plus some spacing
        for (index, button) in ratingButtons.enumerated() {
            buttonFrame.origin.x = CGFloat(index * (buttonSize + padding))
            button.frame = buttonFrame
        }
    }
    
    override public var intrinsicContentSize: CGSize {
        get {
            let buttonSize = Int(frame.size.height)
            let width = (buttonSize * starCount) + (spacing * (starCount - 1))
            
            return CGSize(width: width, height: buttonSize)
        }
    }
    
    // MARK: Button Action
    
    func ratingButtonTapped(button: UIButton) {
            print("Tapped this shit mofo")
    }
}
