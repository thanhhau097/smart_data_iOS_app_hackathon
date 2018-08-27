//
//  DetailBarCell.swift
//  Review
//
//  Created by MAC OS on 8/26/18.
//  Copyright © 2018 MAC OS. All rights reserved.
//

import UIKit

class DetailBarCell: BaseCell {
    
    let categoryName: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 145/255, green: 145/255, blue: 145/255, alpha: 1)
        label.textAlignment = .center
        return label
    }()
    
    override var isHighlighted: Bool {
        didSet {
            categoryName.textColor = isHighlighted ? UIColor.white : UIColor(red: 145/255, green: 145/255, blue: 145/255, alpha: 1)
        }
    }
    
    override var isSelected: Bool {
        didSet {
            categoryName.textColor = isSelected ? UIColor.white : UIColor(red: 145/255, green: 145/255, blue: 145/255, alpha: 1)
        }
    }
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(categoryName)
        addConstraintsWithFormat("H:|[v0]|", views: categoryName)
        addConstraintsWithFormat("V:|[v0]|", views: categoryName)
        
        addConstraint(NSLayoutConstraint(item: categoryName, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: categoryName, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
    }
    
}


