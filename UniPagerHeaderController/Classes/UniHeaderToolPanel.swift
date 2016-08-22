//
//  UniHeaderToolPanel.swift
//  UniPagerHeaderController
//
//  Created by Leo Chang on 8/22/16.
//  Copyright © 2016 Unigreen. All rights reserved.
//

import UIKit

class UniHeaderToolPanel: UICollectionReusableView {

    static let controlHeight : CGFloat = 300
    static let headerIdentifier = "UniHeaderToolPanelID"
    
    @IBOutlet weak var shareButton : UIButton!
    @IBOutlet weak var userNameLabel : UILabel!
    @IBOutlet weak var birthLabel : UILabel!
    @IBOutlet weak var matchedLabel : UILabel!
    @IBOutlet weak var addButton : UIButton!
    @IBOutlet weak var matchNumberLabel : UILabel!
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

    /**
     Update layout according drgging offset form user
     */
    func updateMatchNumber(by offset : CGPoint) {
        
    }
}
