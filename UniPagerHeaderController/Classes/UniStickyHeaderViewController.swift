//
//  UniStickyHeaderViewController.swift
//  UniPagerHeaderController
//
//  Created by Leo Chang on 8/25/16.
//  Copyright © 2016 Unigreen. All rights reserved.
//

import UIKit

class UniStickyHeaderViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var collectionView : UICollectionView!
    @IBOutlet weak var headerToolbar : UIView!
    
    private var stickyHeader : UniHeaderToolPanel?
    private var contentPanel : UIScrollView?
    
    deinit {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let bgImageView = UIImageView(image: UIImage(named : "lighting"))
        bgImageView.frame = CGRect(x: 0, y: 0, width: CGRectGetWidth(UIScreen.mainScreen().bounds), height: 500)
        view.insertSubview(bgImageView, atIndex: 0)
        
        edgesForExtendedLayout = .None
        reloadLayout()
        
        setupUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        reloadLayout()
        if let _ = stickyHeader {
            collectionView.sendSubviewToBack(stickyHeader!)
        }
        updateLayout()
    }
    
    //MARK: - Actions
    @IBAction func cancelButtonPressed(sender : UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    private func reloadLayout() {
        if let layout = collectionView.collectionViewLayout as? CSStickyHeaderFlowLayout {
            layout.parallaxHeaderReferenceSize = CGSize(width: view.frame.width, height: UniHeaderToolPanel.controlHeight)
            layout.parallaxHeaderMinimumReferenceSize = CGSize(width: view.frame.width, height: UniHeaderToolPanel.headerLimitHeight)
            layout.itemSize = CGSize(width: view.frame.width, height: layout.itemSize.height)
            layout.parallaxHeaderAlwaysOnTop = true
            layout.disableStickyHeaders = false
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
            if stickyHeader == nil {
                let header = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: UniHeaderToolPanel.headerIdentifier, forIndexPath: indexPath) as! UniHeaderToolPanel
                stickyHeader = header
            }
            
            return stickyHeader!
        } else if kind == UICollectionElementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: UniContentCell.headerIdentifier, forIndexPath: indexPath) as! UniContentCell
            return header
        }
        return UICollectionReusableView()
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(UniContentCell.cellIdentifier, forIndexPath: indexPath)
        cell.backgroundColor = UIColor.clearColor()
        return cell
        
        //UICollectionViewDelegateFlowLayout
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 9999)
    }
    
    //    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
    //        return CGSize(width: CGRectGetWidth(collectionView.frame), height : 40)
    //    }
    
    //MARK: - UIScrollViewDelegate
    func scrollViewDidScroll(scrollView: UIScrollView) {
        stickyHeader?.updateMatchNumber(by: scrollView.contentOffset)
        updateLayout()
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            stickyHeader?.updateMatchNumber(by: scrollView.contentOffset)
            updateLayout()
        }
    }
    
    func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
        stickyHeader?.updateMatchNumber(by: scrollView.contentOffset)
        updateLayout()
    }
    
    func scrollViewWillBeginDecelerating(scrollView: UIScrollView) {
        stickyHeader?.updateMatchNumber(by: scrollView.contentOffset)
        updateLayout()
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        stickyHeader?.updateMatchNumber(by: scrollView.contentOffset)
        updateLayout()
        //        UIScrollViewDelegate
    }
    
    //MARK: - Private
    private func setupUI() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.clearColor()
        collectionView.registerNib(UINib(nibName: "UniHeaderToolPanel", bundle: nil), forSupplementaryViewOfKind: CSStickyHeaderParallaxHeader, withReuseIdentifier: UniHeaderToolPanel.headerIdentifier)
        collectionView.registerNib(UINib(nibName: "UniContentCell",  bundle: nil), forCellWithReuseIdentifier: UniContentCell.cellIdentifier)
        collectionView.registerNib(UINib(nibName: "UniContentCell", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: UniContentCell.headerIdentifier)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        
        contentPanel = UIScrollView(frame: CGRect.zero)
        contentPanel?.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.7)
        contentPanel?.userInteractionEnabled = false
        contentPanel?.contentSize = CGSize(width: view.frame.width, height: 9999)
        
        for i in 0..<100 {
            let label = UILabel(frame: CGRect(x: 0, y: i * 20, width: 300, height: 20))
            label.font = UIFont.systemFontOfSize(18)
            label.textColor = UIColor.redColor()
            label.text = String(i)
            contentPanel?.addSubview(label)
        }
        view.addSubview(contentPanel!)
        
        headerToolbar.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.3)
    }
    
    private func updateLayout() {
        let offset = collectionView.contentOffset.y
        let baseY = UniHeaderToolPanel.controlHeight
        let diff = UniHeaderToolPanel.controlHeight - UniHeaderToolPanel.headerLimitHeight
        if offset > diff {
            contentPanel?.frame = CGRect(x: 0, y: UniHeaderToolPanel.headerLimitHeight, width: view.frame.width, height: view.frame.height - UniHeaderToolPanel.headerLimitHeight)
            contentPanel?.setContentOffset(CGPoint(x: 0, y: offset - diff), animated: false)
        }
        
        if offset <= diff {
            contentPanel?.frame = CGRect(x: 0, y: baseY - offset, width: view.frame.width, height: view.frame.height - UniHeaderToolPanel.headerLimitHeight)
            contentPanel?.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
        }
        
        if offset <= 64 {
            UIView.animateWithDuration(0.2, animations: { 
                self.headerToolbar.alpha = 1
            })
        } else {
            UIView.animateWithDuration(0.2, animations: {
                self.headerToolbar.alpha = 0
            })
        }
    }

}
