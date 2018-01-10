//
//  HomeVC.swift
//  Frenchie Clone
//
//  Created by Jayven Nhan on 5/2/17.
//  Copyright © 2017 Jayven Nhan. All rights reserved.
//

import UIKit
import Device

class HomeVC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var lblSwipeToBrowse: UILabel!
    
    var emojis = [Emoji]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Perform custom UI setup here
        let cellNib = UINib(nibName: "EmojiCollectionViewCell", bundle: nil)
        collectionView.register(cellNib, forCellWithReuseIdentifier: Constants.Identifiers.EmojiCollectionViewCell)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        pageControl.hidesForSinglePage = true
        var pages: Int = 0
        
        for i in 1...50 {
            let emoji = Emoji(imageName: "\(i)")
            emojis.append(emoji)
        }
        collectionView.reloadData()
        
        configurePageControl()
    }
    
    func configurePageControl() {
        /*** Display the device screen size ***/
        switch Device.size() {
        case .screen4Inch:
            pageControl.numberOfPages = 4
        case .screen4_7Inch:
            pageControl.numberOfPages = 3
        case .screen5_5Inch:
            pageControl.numberOfPages = 2
        default:
            pageControl.numberOfPages = 1
            lblSwipeToBrowse.isHidden = true
        }
    }
    
    func maximumNumberOfCellsInARow() -> Int {
        
        let collectionViewFlowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
        return Int((collectionView.contentSize.width - collectionViewFlowLayout.minimumInteritemSpacing)/(collectionViewFlowLayout.itemSize.width + collectionViewFlowLayout.minimumInteritemSpacing))
    }
    
    @IBAction func btniMessageDidTouch(_ sender: UIButton) {
        performSegue(withIdentifier: Constants.Segues.HomeToiMessageInstruction, sender: nil)
    }
    
    @IBAction func btnKeyboardDidTouch(_ sender: UIButton) {
        performSegue(withIdentifier: Constants.Segues.HomeToInstruction, sender: nil)
    }
}

extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return emojis.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.Identifiers.EmojiCollectionViewCell, for: indexPath) as? EmojiCollectionViewCell {
            let emoji = emojis[indexPath.row]
            if let image = emoji.image {
                cell.imageView.image = image
            }
            return cell
        }
        return UICollectionViewCell()
    }
}

extension HomeVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let length: CGFloat = 64
        let size = CGSize(width: length, height: length)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.CollectionView.Spacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.CollectionView.Spacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let topInset = Constants.CollectionView.InsetTop
        let bottomInset = Constants.CollectionView.InsetTop
        let sideInset = Constants.CollectionView.SideInset
        
        let insets = UIEdgeInsets(top: topInset, left: sideInset, bottom: bottomInset, right: sideInset)
        
        return insets
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageWidth = scrollView.frame.width
        print("HERE")
        print(scrollView.contentOffset.x)
        print(pageWidth)
        pageControl.currentPage = Int((scrollView.contentOffset.x + pageWidth / 2) / pageWidth)
    }
    
}
