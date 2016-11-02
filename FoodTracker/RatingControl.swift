//
//  RatingControl.swift
//  FoodTracker
//
//  Created by Laura Artiles on 10/28/16.
//  Copyright © 2016 Laura Artiles. All rights reserved.
//

import UIKit

class RatingControl: UIView {
    
    // MARK: Properties
    var rating = 0 {
        didSet { // Property observer: observes and responds to changes in a property's value. Called every time a property's value is set, and can be used to perform work immediately before or after the value changes
            setNeedsLayout() // will trigger a layout update every time the rating changes. This ensures that the UI is always showing an accurate representation of the rating property value
        }
    }
    var ratingButtons = [UIButton]()
    let spacing = 5
    let starCount = 5
    
    // MARK: Initialization
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        let filledStarImage = UIImage(named: "filledStar")
        let emptyStarImage = UIImage(named: "emptyStar")
        
        // Creates the 5 rating buttons
        for _ in 0..<starCount {
            let button = UIButton()
            
            // The empty star image appears when a button is unselected
            button.setImage(emptyStarImage, for: .normal)
            button.setImage(filledStarImage, for: .selected)
            button.setImage(filledStarImage, for: [.highlighted, .selected])
            
            button.adjustsImageWhenHighlighted = false //  This is to make sure that the image doesn't show an additional highlight during the state change
            
            button.addTarget(self, action: #selector(RatingControl.ratingButtonTapped(button:)), for: .touchDown)
            ratingButtons += [button] // As each button is created it is added to the ratingButtons array to keep track of it
            addSubview(button)
        }
        
    }
    
    override func layoutSubviews() {
        let buttonSize = Int(frame.size.height)
        print ("Button size inside layoutSubviews: \(buttonSize)")
        
        var buttonFrame = CGRect(x: 0, y: 0, width: 44, height: 44)
        
        // Offset each button's origin by the length of the button plus spacing
        // This code creates a frame and uses a for-in loop to iterate over all of the buttons to set their frames
        for (index, button) in ratingButtons.enumerated() {
            buttonFrame.origin.x = CGFloat(index * (44 + spacing))
            button.frame = buttonFrame
        }
        updateButtonSelectionStates()
    }
    
    override var intrinsicContentSize: CGSize {
        let buttonSize = Int (frame.size.height)
        print ("Button size inside intrinsicContentSize: \(buttonSize)")
        
        let width = (buttonSize + spacing) * starCount
        
        return CGSize(width: width, height: buttonSize)
    }
    
    // MARK: Button Action
    func ratingButtonTapped(button: UIButton) {
        rating = ratingButtons.index(of: button)! + 1
        updateButtonSelectionStates()
    }
    
    func updateButtonSelectionStates() {
        for (index, button) in ratingButtons.enumerated() {
            // If the index of a button is less than the rating then that button should be selected
            button.isSelected = index < rating
        }
    }
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
}

