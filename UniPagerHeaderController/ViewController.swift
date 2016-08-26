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
        edgesForExtendedLayout = .None
        reloadLayout()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.clearColor()
        collectionView.registerNib(UINib(nibName: "ItemCell",  bundle: nil), forCellWithReuseIdentifier: ItemCell.cellIdentifier)
        collectionView.showsVerticalScrollIndicator = true
        collectionView.showsHorizontalScrollIndicator = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    private func reloadLayout() {
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(ItemCell.cellIdentifier, forIndexPath: indexPath) as! ItemCell
        
        cell.refreshImage(for: indexPath.row)
        
        return cell
        
//        UICollectionViewDelegateFlowLayout
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return ItemCell.cellSize
    }
    
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        displayVc(for: indexPath)
        
        if let cell = collectionView.cellForItemAtIndexPath(indexPath) as? ItemCell {
            cell.snapshotViewAfterScreenUpdates(true)
            UIGraphicsBeginImageContextWithOptions(cell.frame.size, false, 0);
            cell.drawViewHierarchyInRect(cell.frame, afterScreenUpdates: true)
            let image : UIImage = UIGraphicsGetImageFromCurrentImageContext();
            if let data = UIImagePNGRepresentation(image) {
                print(image)
            }
        }
    }
    
//    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//        return CGSize(width: CGRectGetWidth(collectionView.frame), height : 40)
//    }
    
    
    //MARK: - Private
    private func displayVc(for indexPath : NSIndexPath) {
        let vc = UniStickyHeaderViewController(nibName: "UniStickyHeaderViewController", bundle: nil)
        vc.modalTransitionStyle = .CrossDissolve
        presentViewController(vc, animated: true, completion: nil)
    }
}

