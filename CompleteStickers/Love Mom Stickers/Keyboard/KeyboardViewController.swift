//
//  KeyboardViewController.swift
//  Keyboard
//
//  Created by Jayven Nhan on 5/4/17.
//  Copyright © 2017 Jayven Nhan. All rights reserved.
//

import UIKit

class KeyboardViewController: UIInputViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet var nextKeyboardButton: UIButton!
    @IBOutlet weak var btnBack: UIButton!
    
    var emojis = [Emoji]()
    var timer: Timer?
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        // Add custom view sizing constraints here
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Perform custom UI setup here
        let nib = UINib(nibName: "KeyboardView", bundle: nil)
        let objects = nib.instantiate(withOwner: self, options: nil)
        view = objects[0] as! UIView;
        self.nextKeyboardButton.addTarget(self, action: #selector(handleInputModeList(from:with:)), for: .allTouchEvents)
        
        let cellNib = UINib(nibName: "EmojiCollectionViewCell", bundle: nil)
        collectionView.register(cellNib, forCellWithReuseIdentifier: Constants.Identifiers.EmojiCollectionViewCell)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        for i in 1...50 {
            let emoji = Emoji(imageName: "\(i)")
            emojis.append(emoji)
        }
        collectionView.reloadData()
        
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(KeyboardViewController.longPressHandler(gesture:)))
        
        btnBack.addGestureRecognizer(longPressRecognizer)
    
    }
    
    func longPressHandler(gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began {
            timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(KeyboardViewController.handleTimer(timer:)), userInfo: nil, repeats: true)
        } else if gesture.state == .ended || gesture.state == .cancelled {
            timer?.invalidate()
            timer = nil
        }
    }
    
    func handleTimer(timer: Timer) {
        textDocumentProxy.deleteBackward()
    }
    
    
    
    fileprivate func configure(){
        collectionView.collectionViewLayout = HorizontalFloatingHeaderLayout()
        func configureCollectionView(){
            collectionView?.contentInset = UIEdgeInsetsMake(8, 8, 8, 8)
        }
        
        func configureHeaderCell(){
            let headerNib = UINib(nibName: "HeaderView",bundle: nil)
            collectionView?.register(headerNib, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "HeaderView")
        }
        
        configureCollectionView()
        configureHeaderCell()
    }

    override func textWillChange(_ textInput: UITextInput?) {
        
    }
    
    override func textDidChange(_ textInput: UITextInput?) {

    }
    
    @IBAction func btnGlobeDidTouch(_ sender: UIButton) {
        
    }

    @IBAction func btnDeleteDidTouch(_ sender: Any) {
        (textDocumentProxy as UIKeyInput).deleteBackward()
    }
    
    @IBAction func btnLoveYouMom(_ sender: UIButton) {
        if let text = sender.titleLabel?.text as? String {
            (textDocumentProxy as UIKeyInput).insertText(text)
        }
        
    }
}

extension KeyboardViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let emoji = emojis[indexPath.row]
        let image = emoji.image!
        
        UIPasteboard.general.image = image
        copyToClipboardAnimation()
    }
    
    func copyToClipboardAnimation() {
        let coverView = UIView(frame: self.view.frame)
        self.view.addSubview(coverView)
        let label = UILabel()
        coverView.addSubview(label)
        
        coverView.backgroundColor = .black
        coverView.alpha = 0
        
        label.sizeToFit()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: coverView.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: coverView.centerYAnchor).isActive = true
        label.textColor = .white
        label.text = "Emoji copied. Now paste it into \n your message above ⬆️!"
        
        coverView.flash { (complete) in
            if complete {
                coverView.removeFromSuperview()
            }
        }
    }
}

extension KeyboardViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return emojis.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.Identifiers.EmojiCollectionViewCell, for: indexPath) as? EmojiCollectionViewCell {
            print(indexPath.row)
            let emoji = emojis[indexPath.row]
            if let image = emoji.image {
                cell.imageView.image = image
            }
            return cell
        }
        return UICollectionViewCell()
    }
}

extension KeyboardViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let length = (self.collectionView.frame.height - (Constants.CollectionView.InsetTop * 2) ) / 3 - (Constants.CollectionView.Spacing)
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
        let sideInset: CGFloat = 8
        
        let insets = UIEdgeInsets(top: topInset, left: sideInset, bottom: bottomInset, right: sideInset)
        
        return insets
    }
}

//extension KeyboardViewController: HorizontalFloatingHeaderLayoutDelegate {
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        let topInset = Constants.CollectionView.InsetTop
//        let bottomInset = Constants.CollectionView.InsetTop
//        let sideInset = Constants.CollectionView.SideInset
//        
//        let insets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//        
//        return insets
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, horizontalFloatingHeaderItemSizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
//        
//        let length = (self.collectionView.frame.height - (Constants.CollectionView.InsetTop * 2) - Constants.CollectionView.HeaderHeight) / 3 - (Constants.CollectionView.Spacing)
//        let size = CGSize(width: length, height: length)
//        return size
//
//    }
//    
//    
//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        if let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderView", for: indexPath) as? HeaderView {
//            print("Im here")
//            header.lblName.text = "I'm here"
//            return header
//        }
//        return UICollectionReusableView()
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, horizontalFloatingHeaderSizeForSectionAtIndex section: Int) -> CGSize {
//        let size = CGSize(width: 160, height: Constants.CollectionView.HeaderHeight)
//        return size
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, horizontalFloatingHeaderSectionInsetForSectionAtIndex section: Int) -> UIEdgeInsets {
//
//        switch section{
//        case 0:
//            return UIEdgeInsetsMake(0, 8, 0, 8)
//        default:
//            return UIEdgeInsetsMake(0, 8, 0, 8)
//        }
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, horizontalFloatingHeaderItemSpacingForSectionAtIndex section: Int) -> CGFloat {
//        return 8.0
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, horizontalFloatingHeaderColumnSpacingForSectionAtIndex section: Int) -> CGFloat {
//        return 8.0
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return Constants.CollectionView.Spacing
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return Constants.CollectionView.Spacing
//    }
//
//}
