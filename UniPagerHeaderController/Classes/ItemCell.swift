//
//  ItemCell.swift
//  UniPagerHeaderController
//
//  Created by Leo Chang on 8/23/16.
//  Copyright © 2016 Unigreen. All rights reserved.
//

import UIKit

class ItemCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource {

    static let cellIdentifier = "ItemCellID"
    static let headerIdentifier = "headerIdentifierID"
    
    var currentSelectedIndex : Int = 0
    var indicatorLineFrame = CGRect.zero
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
        refreshButtonState()
    }
    
    override func layoutSubviews() {
        superview?.bringSubviewToFront(self)
    }
    
    //MARK: - Actions
    @IBAction func buttonPressed(sender : UIButton) {
        currentSelectedIndex = sender.tag
        refreshButtonState()
    }

    //MARK: - Private
    private func setupUI() {
//        collectionView.backgroundView = nil
//        collectionView.backgroundColor = UIColor.clearColor()
//        collectionView.delegate = self
//        collectionView.dataSource = self
//        collectionView.registerNib(UINib(nibName: "UGContentCell",bundle: nil), forCellWithReuseIdentifier: UGContentCell.cellIdentifier)
    }
    
    private func refreshButtonState() {
        indicatorLineFrame = frame
    }
    
    //MARK: - UICollectionViewDelegate, UICollectionViewDataSource
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(UGContentCell.cellIdentifier, forIndexPath: indexPath) as! UGContentCell
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: frame.width, height: 1000)
    }
}
