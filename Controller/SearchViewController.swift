//
//  SearchViewController.swift
//  Review
//
//  Created by MAC OS on 8/27/18.
//  Copyright © 2018 MAC OS. All rights reserved.
//

import UIKit

class SearchViewController: CustomViewController, UISearchBarDelegate, UITextFieldDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(categotyCollectionView)
//        view.addConstraintsWithFormat("V:|[v0]|", views: categotyCollectionView)
//        view.addConstraintsWithFormat("H:|[v0]|", views: categotyCollectionView)
        categotyCollectionView.frame = view.frame
        test_map()
    }

    let categotyCollectionView = CategoryCollectionView()
    
    func test_map() {
        let detailButton = UIBarButtonItem(title: "Maps", style: .plain, target: self, action: #selector(goToDetailViewWithID))
        
        navigationItem.setRightBarButton(detailButton, animated: false)
    }
    
    @objc func goToDetailViewWithID() {
        let mapViewController = MapViewController()
        navigationController?.pushViewController(mapViewController, animated: true)
    }
    
}






