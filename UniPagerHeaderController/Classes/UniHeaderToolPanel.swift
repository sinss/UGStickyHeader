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
    static let headerIdentifier = "UniHeaderToolPanelID"
    
    let numberWidth : CGFloat = 150
    let bottomLabel : CGFloat = 40
    let limitY : CGFloat = 40
    let limitX : CGFloat = 5
    
    @IBOutlet weak var shareButton : UIButton!
    @IBOutlet weak var userNameLabel : UILabel!
    @IBOutlet weak var birthLabel : UILabel!
    @IBOutlet weak var matchedLabel : UILabel!
    @IBOutlet weak var addButton : UIButton!
    @IBOutlet weak var matchNumberLabel : UILabel!
    var bgImageView : UIImageView!
    
    var calculateFrame = CGRect.zero
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bgImageView = UIImageView(image: UIImage(named : "lighting"))
        bgImageView.frame = CGRect(x: 0, y: 0, width: CGRectGetWidth(UIScreen.mainScreen().bounds), height: 500)
        insertSubview(bgImageView, atIndex: 0)
        
        bringSubviewToFront(shareButton!)
        bringSubviewToFront(userNameLabel!)
        bringSubviewToFront(birthLabel!)
        bringSubviewToFront(addButton!)
        bringSubviewToFront(matchNumberLabel!)
        bringSubviewToFront(matchedLabel!)
    }

    override func layoutSubviews() {
        //matchNumberLabel.frame = CGRect(x: frame.width / 2 - numberWidth / 2 , y: frame.height - numberWidth, width: numberWidth, height: numberWidth)
        super.layoutSubviews()
        if calculateFrame == CGRect.zero {
            calculateFrame = CGRect(x: frame.width / 2 - (numberWidth * 0.6) / 2 , y: frame.height - numberWidth, width: numberWidth * 0.6, height: numberWidth)
            matchNumberLabel.frame = calculateFrame
        }
    }
    /**
     Update layout according drgging offset form user
     */
    func updateMatchNumber(by offset : CGPoint) {
        let originalFrame = CGRect(x: frame.width / 2 - (numberWidth * 0.6) / 2 , y: frame.height - numberWidth, width: numberWidth * 0.6, height: numberWidth)
        var calculateX = originalFrame.origin.x
        var calculateY = originalFrame.origin.y
        let totalOffset : CGFloat = 190
        let factor : CGFloat =  max(1 - (offset.y / totalOffset) * 0.3, 0.4)
        if offset.y < totalOffset && offset.y > 0 {
            calculateY = originalFrame.origin.y - offset.y * (offset.y / totalOffset)
            calculateY = round(calculateY)
            calculateY = max(0, calculateY)
            calculateX = originalFrame.origin.x - originalFrame.origin.x * (offset.y / totalOffset) + 5
            calculateX = round(calculateX)
            calculateX = max(5, calculateX)
        } else {
            //matchNumberLabel.frame = CGRect(x: 5, y: 40, width: originalFrame.width, height: originalFrame.height)
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
}
