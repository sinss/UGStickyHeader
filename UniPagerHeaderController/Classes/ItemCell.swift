//
//  ItemCell.swift
//  UniPagerHeaderController
//
//  Created by Leo Chang on 8/23/16.
//  Copyright © 2016 Unigreen. All rights reserved.
//

import UIKit

class ItemCell: UICollectionViewCell {

    static let cellIdentifier = "ItemCellID"
    static let headerIdentifier = "headerIdentifierID"
    
    static var cellSize : CGSize {
        get {
            let width = UIScreen.mainScreen().bounds.width / 2
            return CGSize(width: width, height: width)
        }
    }
    
    @IBOutlet weak var numberLabel : UILabel!
    @IBOutlet weak var imgv : UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }

    func refreshImage(for index : Int) {
        let imageName = String(format: "icon_%li", index)
        imgv.image = UIImage(named: imageName)
        numberLabel.text = String(index + 1)
    }
    //MARK: - Private
    private func setupUI() {
        imgv.layer.borderWidth = 1
        imgv.layer.borderColor = UIColor.blackColor().CGColor
    }
    
    private func refreshButtonState() {
        
    }
}
