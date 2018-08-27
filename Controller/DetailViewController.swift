//
//  DetailViewController.swift
//  Review
//
//  Created by MAC OS on 8/27/18.
//  Copyright © 2018 MAC OS. All rights reserved.
//

import UIKit

class DetailViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    override func viewDidLoad() {
        super.viewDidLoad()
        

        navigationItem.title = place?.name
        
        
        
        setupCollectionView()
        setupDetailBar()
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.addSubview(backgroundImageView)
        backgroundImageView.frame = view.frame
        view.bringSubview(toFront: collectionView!)
        view.bringSubview(toFront: detailBar)
    }
    
    
    
    let backgroundImageView = UIImageView(image: UIImage(named: "background"))
    
    var id: String! = ""
    var place: Place?
    let hightlightCellId = "hightlightCellId"
    let infoCellId = "infoCellId"
    let tipsCellId = "tipsCellId"
    
    func setupViews() {
        if place == nil {
            getPlaceWithId(id) { (place) in
                if let place = place {
                    self.place = place
                    self.collectionView?.reloadData()
                }
            }
        }
        
    }

    func setupCollectionView(){
        collectionView?.register(HightlightView.self, forCellWithReuseIdentifier: hightlightCellId)
        collectionView?.register(InfoView.self, forCellWithReuseIdentifier: infoCellId)
        collectionView?.register(TipsView.self, forCellWithReuseIdentifier: tipsCellId)
        
        
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0
        }
        
        collectionView?.backgroundColor = .clear
        let yInset = view.frame.height * 15/192
        collectionView?.contentInset = UIEdgeInsetsMake(yInset, 0, 0, 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(yInset, 0, 0, 0)
        
        collectionView?.isPagingEnabled = true
    }
    
    lazy var detailBar: DetailBar = {
        let bar = DetailBar()
        bar.detailViewController = self
        return bar
    }()
    
    func setupDetailBar(){
        view.addSubview(detailBar)
        let y = view.frame.height * 17/192
        let height = view.frame.height * 15/192
        detailBar.frame = CGRect(x: 0, y: y, width: view.frame.width, height: height)
    }
    

    
    
    
    
    func scrollToMenuIndex(_ menuIndex: Int) {
        let indexPath = IndexPath(item: menuIndex, section: 0)
        collectionView?.scrollToItem(at: indexPath, at: UICollectionViewScrollPosition(), animated: true)
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        detailBar.horizontalBarLeftAnchorConstraint?.constant = scrollView.contentOffset.x / 3
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let index = targetContentOffset.pointee.x / view.frame.width
        
        let indexPath = IndexPath(item: Int(index), section: 0)
        detailBar.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: UICollectionViewScrollPosition())
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.item == 0{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: infoCellId, for: indexPath) as! InfoView
            //            cell.nameLabel.text = place?.name
            cell.typeLabel.isHidden = true
            //            cell.typeLabel.text = place?.type
            cell.nameLabel.isHidden = true
            cell.addressContentLabel.text = place?.address
            cell.phoneContentLabel.text = place?.phoneNumber
            cell.websiteContentLabel.text = place?.website
            if let url = place?.photoUrl {
                cell.imageView.loadImageUsing(urlString: url)
            }
            
            cell.detailViewController = self
            return cell
        }else if indexPath.item == 1{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: hightlightCellId, for: indexPath) as! HightlightView
            if let rate = place?.rate {
                cell.pointLabel.text = String(rate)
            }
            cell.detailViewController = self
            return cell
            
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: tipsCellId, for: indexPath) as! TipsView
        if let comments = place?.comments {
            cell.comments = comments
        }
        cell.detailViewController = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height * 160/192 - 21)
    }
}











