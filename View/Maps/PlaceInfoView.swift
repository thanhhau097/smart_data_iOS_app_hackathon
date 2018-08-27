//
//  PlaceInfoView.swift
//  Review
//
//  Created by MAC OS on 8/26/18.
//  Copyright © 2018 MAC OS. All rights reserved.
//

import UIKit

class PlaceInfoView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        
        addSubview(placeImageView)
        addConstraintsWithFormat("H:|-4-[v0(50)]", views: placeImageView)
        addConstraintsWithFormat("V:|-8-[v0(50)]", views: placeImageView)
        
        addSubview(ratingLabel)
        addConstraintsWithFormat("H:[v0(30)]-8-|", views: ratingLabel)
        addConstraintsWithFormat("V:|-8-[v0(30)]", views: ratingLabel)
        
        // 8 + 40 + 4+ 21 + 4 + 40 + 8
        addSubview(placeNameLabel)
        addConstraintsWithFormat("V:|-8-[v0(40)]", views: placeNameLabel)
        placeNameLabel.leftAnchor.constraint(equalTo: placeImageView.rightAnchor, constant: 16).isActive = true
        placeNameLabel.rightAnchor.constraint(equalTo: ratingLabel.leftAnchor, constant: -16).isActive = true

        addSubview(placeTypeLabel)
        placeTypeLabel.leftAnchor.constraint(equalTo: placeNameLabel.leftAnchor).isActive = true
        placeTypeLabel.rightAnchor.constraint(equalTo: placeNameLabel.rightAnchor).isActive = true
        placeTypeLabel.topAnchor.constraint(equalTo: placeNameLabel.bottomAnchor, constant: 4).isActive = true
        placeTypeLabel.heightAnchor.constraint(equalToConstant: 21).isActive = true

        addSubview(addressLabel)
        addressLabel.leftAnchor.constraint(equalTo: placeNameLabel.leftAnchor).isActive = true
        addressLabel.rightAnchor.constraint(equalTo: placeNameLabel.rightAnchor).isActive = true
        addressLabel.topAnchor.constraint(equalTo: placeTypeLabel.bottomAnchor, constant: 4).isActive = true
        addressLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        addSubview(detailButton)
        addConstraintsWithFormat("H:[v0(70)]-16-|", views: detailButton)
        addConstraintsWithFormat("V:[v0(30)]-16-|", views: detailButton)
    }
    
    let placeImageView: CustomImageView  = {
        let imageView = CustomImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 5
        imageView.contentMode = .scaleToFill
        imageView.backgroundColor = UIColor.gray
        
        return imageView
    }()
    
    let placeNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = UIColor.cyan

        label.numberOfLines = 0
        
        return label
    }()
    
    let placeTypeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = label.font.withSize(14)
        label.textColor = UIColor.gray

        label.numberOfLines = 0
        return label
    }()
    
    let addressLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = label.font.withSize(14)
        label.textColor = UIColor.lightGray

        label.numberOfLines = 0
        return label
    }()
    
    let ratingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.white
        label.layer.cornerRadius = 5
        label.backgroundColor = UIColor.green

        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 14)
        
        
        return label
    }()
    
    let detailButton: UIButton = {
        let button = UIButton(type: UIButtonType.system)
        button.setTitle("Detail", for: UIControlState.normal)
        button.layer.cornerRadius = 5
        button.backgroundColor = UIColor.green
        
        return button
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
