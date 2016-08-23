//
//  ViewController.swift
//  UniPagerHeaderController
//
//  Created by Leo Chang on 8/22/16.
//  Copyright © 2016 Unigreen. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var collectionView : UICollectionView!
    
    private var stickyHeader : UniHeaderToolPanel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        edgesForExtendedLayout = .None
        reloadLayout()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.whiteColor()
        collectionView.registerNib(UINib(nibName: "UniHeaderToolPanel", bundle: nil), forSupplementaryViewOfKind: CSStickyHeaderParallaxHeader, withReuseIdentifier: UniHeaderToolPanel.headerIdentifier)
        collectionView.registerNib(UINib(nibName: "ItemCell",  bundle: nil), forCellWithReuseIdentifier: ItemCell.cellIdentifier)
        collectionView.registerNib(UINib(nibName: "ItemCell", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: ItemCell.headerIdentifier)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    private func reloadLayout() {
        if let layout = collectionView.collectionViewLayout as? CSStickyHeaderFlowLayout {
            layout.parallaxHeaderReferenceSize = CGSize(width: view.frame.width, height: UniHeaderToolPanel.controlHeight)
            layout.parallaxHeaderMinimumReferenceSize = CGSize(width: view.frame.width, height: 110)
            layout.itemSize = CGSize(width: view.frame.width, height: layout.itemSize.height)
            layout.parallaxHeaderAlwaysOnTop = true
            layout.disableStickyHeaders = true
        }
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        if kind == CSStickyHeaderParallaxHeader {
            if stickyHeader == nil {
                let header = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: UniHeaderToolPanel.headerIdentifier, forIndexPath: indexPath) as! UniHeaderToolPanel
                stickyHeader = header
            }
            
            return stickyHeader!
        } else if kind == UICollectionElementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: ItemCell.headerIdentifier, forIndexPath: indexPath) as! ItemCell
            return header
        }
        return UICollectionReusableView()
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(ItemCell.cellIdentifier, forIndexPath: indexPath)
        cell.backgroundColor = UIColor.grayColor()
        return cell
    }
    
//    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//        return CGSize(width: CGRectGetWidth(collectionView.frame), height : 40)
//    }
    
    //MARK: - UIScrollViewDelegate
    func scrollViewDidScroll(scrollView: UIScrollView) {
        stickyHeader?.updateMatchNumber(by: scrollView.contentOffset)
    }
}

