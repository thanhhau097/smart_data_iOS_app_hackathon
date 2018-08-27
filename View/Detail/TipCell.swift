//
//  TipCell.swift
//  Review
//
//  Created by MAC OS on 8/26/18.
//  Copyright © 2018 MAC OS. All rights reserved.
//

import UIKit

class TipCell: BaseCell {
    override func setupViews() {
        super.setupViews()
        
        addSubview(userImageView)
        addConstraintsWithFormat("H:|-16-[v0(40)]", views: userImageView)
        addConstraintsWithFormat("V:|-16-[v0(40)]", views: userImageView)
        
        addSubview(usernameLabel)
        addConstraintsWithFormat("H:|-72-[v0]-16-|", views: usernameLabel)
        addConstraintsWithFormat("V:|-25-[v0(21)]", views: usernameLabel)
        
        addSubview(pointLabel)
        addConstraintsWithFormat("V:|-16-[v0(30)]", views: pointLabel)
        addConstraintsWithFormat("H:[v0(60)]-16-|", views: pointLabel)

        
        addSubview(textLabel)
        addConstraintsWithFormat("H:|-16-[v0]-16-|", views: textLabel)
        textLabel.topAnchor.constraint(equalTo: userImageView.bottomAnchor, constant: 8).isActive = true
        textLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16).isActive = true
    }
    
    let userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "image")
        imageView.layer.cornerRadius = 20
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let usernameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "Nguyen Van A"
        return label
    }()
    
    let textLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.text = "Trong nhóm mình có ai có laptop không cần dùng nữa muốn bán lại không ạ? Mình muốn mua ạ."
        
        return label
    }()
    
    let pointLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = UIColor.green
        label.text = "5.2 points"
        return label
    }()
}
