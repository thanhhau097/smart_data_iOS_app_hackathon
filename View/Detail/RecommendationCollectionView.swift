//
//  RecommendationCollectionView.swift
//  Review
//
//  Created by MAC OS on 8/27/18.
//  Copyright © 2018 MAC OS. All rights reserved.
//

import UIKit

class RecommendationCollectionView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(collectionView)
        addConstraintsWithFormat("H:|[v0]|", views: collectionView)
        addConstraintsWithFormat("V:|[v0]|", views: collectionView)
        collectionView.register(RecommendationCell.self, forCellWithReuseIdentifier: cellId)
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0
        }
        
//        collectionView?.backgroundColor = .clear
//        let yInset = view.frame.height * 15/192
//        collectionView?.contentInset = UIEdgeInsetsMake(yInset, 0, 0, 0)
//        collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(yInset, 0, 0, 0)
//
        collectionView.isPagingEnabled = true
        
        
        test_place()
    }
    
    func test_place() {
        for _ in 1...10 {
            let place = Place(id: "12345678", name: "Ha noi", address: "Ha nOi", phoneNumber: "261739709", type: "Coffee")
            
            places.append(place)
        }
        
        collectionView.reloadData()
    }
    
    var places = [Place]()
    let cellId = "cellId"
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.clear
        cv.dataSource = self
        cv.delegate = self
        cv.contentInset = UIEdgeInsetsMake(0, 10, 0, 10)
        return cv
    }()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return places.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! RecommendationCell
        let place = places[indexPath.item]
//        cell.imageView.image = UIImage(named: "")
        cell.nameLabel.text = place.name
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
