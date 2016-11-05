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
    
    var rating = 0 {
        didSet{
            setNeedsLayout()
        }
    }
    
    var ratingButtons = [UIButton]()

    // MARK: Initialization
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
 
        let emptyStar = UIImage(named: "emptyStar")
        let filledStar = UIImage(named: "filledStar")
        
        for _ in 0 ..< starCount {
            let button = UIButton()
            
            // Set images for button states
            button.setImage(emptyStar, for: .normal)
            button.setImage(filledStar, for: .selected)
            button.setImage(filledStar, for: [.highlighted, .selected])
            
            button.adjustsImageWhenHighlighted = false
            
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
        
        updateSelectedButtonStates()
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
        rating = ratingButtons.index(of: button)! + 1
        
        updateSelectedButtonStates()
    }
    
    func updateSelectedButtonStates() {
        for (index, button) in ratingButtons.enumerated() {
            button.isSelected = index < rating
        }
    }
}
