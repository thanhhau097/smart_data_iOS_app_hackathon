//
//  TipsView.swift
//  Review
//
//  Created by MAC OS on 8/27/18.
//  Copyright © 2018 MAC OS. All rights reserved.
//

import UIKit
import AVFoundation


class TipsView: BaseCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    override func setupViews() {
        super.setupViews()
        backgroundColor = UIColor.init(white: 1, alpha: 0.33)

        addSubview(collectionView)
        addConstraintsWithFormat("H:|[v0]|", views: collectionView)
        addConstraintsWithFormat("V:|[v0]-50-|", views: collectionView)
        collectionView.register(TipCell.self, forCellWithReuseIdentifier: cellId)
        
        setupCommentView()
        test_comments()
    }
    
    func test_comments() {
        let comment = Comment(userImageName: "image", username: "Nguyen Van A", text: "Swift provides two kinds of loops that perform a set of statements a certain number of times:Swift provides two kinds of loops that perform a set of statements a certain number of times:Swift provides two kinds of loops that perform a set of statements a certain number of times:", point: 1)
        
        for _ in 1...10 {
            comments.append(comment)
        }
    }
    
    var detailViewController: DetailViewController?
    var comments = [Comment]()
    let cellId = "cellId"
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.clear
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    let addCommentView = AddCommentView()
    
    func setupCommentView() {
        addCommentView.backgroundColor = UIColor.init(white: 1, alpha: 0.66)
        addSubview(addCommentView)
        addConstraintsWithFormat("H:|[v0]|", views: addCommentView)
        addConstraintsWithFormat("V:[v0(50)]|", views: addCommentView)
        
        addCommentView.commentButton.addTarget(self, action: #selector(handleSendComment), for: UIControlEvents.touchUpInside)
    }
    
    @objc func handleSendComment() {
        if let text = addCommentView.inputTextField.text {
            if text != "" {
                let comment = Comment()
                comment.username = "Me"
                comment.userImageName = "image"
                comment.text = text
                
                getPointForComment(text, completion: { (rate) in
                    if rate != 0 {
                        comment.point = rate
                        self.comments.append(comment)
                        self.collectionView.reloadData()
                        let lastItemIndex = NSIndexPath(item: self.comments.count - 1, section: 0)
                        self.collectionView.scrollToItem(at: lastItemIndex as IndexPath, at: .bottom, animated: true)
                        
                        
                        self.addCommentView.inputTextField.text = ""
                    }
                })
            }
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return comments.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! TipCell
        let comment = comments[indexPath.item]
        cell.textLabel.text = comment.text
        cell.usernameLabel.text = comment.username
        cell.userImageView.image = UIImage(named: "image")
        if let point = comment.point {
            cell.pointLabel.text = String(point) + " points"
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: frame.width, height: 100)
        // lấy độ cao theo text
        if let text = comments[indexPath.item].text {
            let rect = NSString(string: text).boundingRect(with: CGSize(width: frame.width - 32, height: 1000), options: NSStringDrawingOptions.usesFontLeading.union(NSStringDrawingOptions.usesLineFragmentOrigin), attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)], context: nil)
            
            let knownHeight: CGFloat = 80
            
            return CGSize(width: frame.width, height: rect.height + knownHeight + 30)
        }
        return CGSize(width: frame.width, height: 500)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
}








