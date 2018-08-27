//
//  RecommendationCell.swift
//  Review
//
//  Created by MAC OS on 8/27/18.
//  Copyright © 2018 MAC OS. All rights reserved.
//

import UIKit

class RecommendationCell: BaseCell {
    override func setupViews() {
        super.setupViews()
        
        layer.cornerRadius = 10
        layer.masksToBounds = true
        
        addSubview(imageView)
        addConstraintsWithFormat("H:|[v0]|", views: imageView)
        addConstraintsWithFormat("V:|[v0]|", views: imageView)
        
        addSubview(nameLabel)
        addConstraintsWithFormat("H:|-16-[v0]|", views: nameLabel)
        addConstraintsWithFormat("V:[v0(30)]-16-|", views: nameLabel)
    }
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = UIColor.init(white: 1, alpha: 0.33)
        
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "Test Name"
        
        return label
    }()
}
