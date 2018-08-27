//
//  SearchView.swift
//  Review
//
//  Created by MAC OS on 8/27/18.
//  Copyright © 2018 MAC OS. All rights reserved.
//

import UIKit

class SearchView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layer.cornerRadius = 10
        layer.borderColor = UIColor.gray.cgColor
        
        addSubview(searchButton)
        addConstraintsWithFormat("V:|[v0]|", views: searchButton)
        addConstraintsWithFormat("H:|-16-[v0]|", views: searchButton)
        
        addSubview(qrCodeButton)
        addConstraintsWithFormat("V:|[v0]|", views: qrCodeButton)
        addConstraintsWithFormat("H:[v0]-8-|", views: qrCodeButton)
        qrCodeButton.widthAnchor.constraint(equalTo: self.heightAnchor, constant: 0).isActive = true
        
        

        
    }
    
    let searchButton: UIButton = {
        let button = UIButton(type: UIButtonType.system)
        button.setTitle("Search ...", for: UIControlState.normal)
        button.setTitleColor(UIColor.lightGray, for: UIControlState.normal)
        button.contentHorizontalAlignment = .left
        return button
    }()
    
    let qrCodeButton: UIButton = {
        let button = UIButton(type: UIButtonType.system)
        button.setBackgroundImage(UIImage(named: "qr_code"), for: UIControlState.normal)
        button.layer.cornerRadius = 10
        
        return button
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
