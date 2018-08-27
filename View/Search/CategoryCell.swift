//
//  CategoryCell.swift
//  Review
//
//  Created by MAC OS on 8/26/18.
//  Copyright © 2018 MAC OS. All rights reserved.
//

import UIKit

class CategoryCell: BaseCell {
    override func setupViews() {
        super.setupViews()
        
        backgroundColor = UIColor.init(white: 1, alpha: 0.33)
        
        addSubview(titleLabel)
        addConstraintsWithFormat("V:|[v0]|", views: titleLabel)
        addConstraintsWithFormat("H:|-16-[v0]|", views: titleLabel)
        
    }
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = UIColor.white
//        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
}
