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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        reloadLayout()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerNib(UINib(nibName: "UniHeaderToolPanel", bundle: nil), forSupplementaryViewOfKind: CSStickyHeaderParallaxHeader, withReuseIdentifier: UniHeaderToolPanel.headerIdentifier)
        collectionView.registerClass(UICollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "cell")
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
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        if kind == CSStickyHeaderParallaxHeader {
            let header = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: UniHeaderToolPanel.headerIdentifier, forIndexPath: indexPath)
            
            return header
        }
        return UICollectionReusableView()
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath)
        return cell
    }
}

