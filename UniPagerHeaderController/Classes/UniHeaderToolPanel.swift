//
//  UniHeaderToolPanel.swift
//  UniPagerHeaderController
//
//  Created by Leo Chang on 8/22/16.
//  Copyright © 2016 Unigreen. All rights reserved.
//

import UIKit

class UniHeaderToolPanel: UICollectionViewCell {

    static let controlHeight : CGFloat = 300
    static let headerLimitHeight : CGFloat = 140
    static let headerIdentifier = "UniHeaderToolPanelID"
    
    let numberWidth : CGFloat = 100
    let bottomLabel : CGFloat = 40
    let limitY : CGFloat = 30
    let limitX : CGFloat = 5
    
    @IBOutlet weak var shareButton : UIButton!
    @IBOutlet weak var userNameLabel : UILabel!
    @IBOutlet weak var birthLabel : UILabel!
    @IBOutlet weak var matchedLabel : UILabel!
    @IBOutlet weak var addButton : UIButton!
    @IBOutlet weak var matchNumberLabel : UILabel!
    
    @IBOutlet weak var generalButton : UIButton!
    @IBOutlet weak var relationshipButton : UIButton!
    @IBOutlet weak var careerButton : UIButton!
    @IBOutlet weak var indicatorLine : UIView!
    
    var bgImageView : UIImageView!
    
    var calculateFrame = CGRect.zero
    var currentSelectedIndex : Int = 0
    var indicatorLineFrame = CGRect.zero
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor.clearColor()
        
        bringSubviewToFront(shareButton!)
        bringSubviewToFront(userNameLabel!)
        bringSubviewToFront(birthLabel!)
        bringSubviewToFront(addButton!)
        bringSubviewToFront(matchNumberLabel!)
        bringSubviewToFront(matchedLabel!)
        
        generalButton.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.7)
        relationshipButton.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.7)
        careerButton.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.7)
        refreshButtonState()
    }

    override func layoutSubviews() {
        //matchNumberLabel.frame = CGRect(x: frame.width / 2 - numberWidth / 2 , y: frame.height - numberWidth, width: numberWidth, height: numberWidth)
        super.layoutSubviews()
        if calculateFrame == CGRect.zero {
            calculateFrame = CGRect(x: frame.width / 2 - (numberWidth * 0.8) / 2 , y: frame.height - numberWidth - 40, width: numberWidth * 0.8, height: numberWidth)
            matchNumberLabel.frame = calculateFrame
        }
        
        let width = frame.width / 3
        let buttonHeight = generalButton.frame.height
        let buttons = [generalButton, relationshipButton, careerButton]
        var i = 0
        for button in buttons {
            button.frame = CGRect(x: CGFloat(i) * width, y: frame.height - buttonHeight, width: width, height: buttonHeight)
            i += 1
        }
        indicatorLineFrame.origin.y = frame.height-1
        indicatorLineFrame.size.width = width
        indicatorLineFrame.size.height = 1
        indicatorLine.frame = self.indicatorLineFrame
    }
    /**
     Update layout according drgging offset form user
     */
    func updateMatchNumber(by offset : CGPoint) {
        let originalFrame = CGRect(x: frame.width / 2 - (numberWidth * 0.8) / 2 , y: frame.height - numberWidth - 30, width: numberWidth * 0.8, height: numberWidth)
        var calculateX = originalFrame.origin.x
        var calculateY = originalFrame.origin.y
        let totalOffset : CGFloat = (UniHeaderToolPanel.controlHeight - UniHeaderToolPanel.headerLimitHeight)
        let factor : CGFloat =  max(1 - (offset.y / totalOffset) * 0.3, 0.6)
        if offset.y < totalOffset && offset.y > 0 {
            calculateY = originalFrame.origin.y - offset.y * (offset.y / totalOffset)
            calculateY = round(calculateY)
            calculateY = max(0, calculateY)
            calculateX = originalFrame.origin.x - originalFrame.origin.x * (offset.y / totalOffset) + 5
            calculateX = round(calculateX)
            calculateX = max(5, calculateX)
        } else {
            if offset.y >= totalOffset {
                matchNumberLabel.transform = CGAffineTransformMakeScale(0.6, 0.6)
                matchNumberLabel.frame = CGRect(x: 5, y: 0, width: originalFrame.width, height: originalFrame.height)
            } else if offset.y <= 0 {
                matchNumberLabel.transform = CGAffineTransformMakeScale(1, 1)
                matchNumberLabel.frame = CGRect(x: frame.width / 2 - (numberWidth * 0.8) / 2 , y: frame.height - numberWidth - 40, width: numberWidth * 0.8, height: numberWidth)
            }
            return
        }
        if factor > 1 {
            matchNumberLabel.transform = CGAffineTransformMakeScale(1, 1)
        } else {
            matchNumberLabel.transform = CGAffineTransformMakeScale(factor, factor)
        }
        print(calculateFrame)
        print(offset)
        calculateFrame = CGRect(x: calculateX, y: calculateY, width: originalFrame.width, height: originalFrame.height)
        matchNumberLabel.frame = calculateFrame
    }
    
    private func refreshButtonState() {
        let buttons = [generalButton, relationshipButton, careerButton]
        for button in buttons {
            button.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
        }
        var frame = indicatorLine.frame
        switch (currentSelectedIndex) {
        case 1:
            generalButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
            frame.origin.x = generalButton.frame.origin.x
        case 2:
            relationshipButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
            frame.origin.x = relationshipButton.frame.origin.x
        case 3:
            careerButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
            frame.origin.x = careerButton.frame.origin.x
        default:
            generalButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
            frame.origin.x = generalButton.frame.origin.x
        }
        indicatorLineFrame = frame
        UIView.animateWithDuration(0.3) {
            self.indicatorLine.frame = self.indicatorLineFrame
        }
    }
    
    //MARK: - Actions
    @IBAction func buttonPressed(sender : UIButton) {
        currentSelectedIndex = sender.tag
        refreshButtonState()
    }
}
