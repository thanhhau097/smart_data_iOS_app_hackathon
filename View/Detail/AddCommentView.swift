//
//  AddCommentView.swift
//  Review
//
//  Created by MAC OS on 8/26/18.
//  Copyright © 2018 MAC OS. All rights reserved.
//

import UIKit

class AddCommentView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(commentButton)
        addConstraintsWithFormat("H:[v0(60)]-16-|", views: commentButton)
        commentButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        commentButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        addSubview(inputTextField)
        addConstraintsWithFormat("V:|[v0]|", views: inputTextField)
        addConstraintsWithFormat("H:|-16-[v0]", views: inputTextField)
        inputTextField.rightAnchor.constraint(equalTo: commentButton.leftAnchor).isActive = true
        
    }
    
    let inputTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Write your comment ... "
        
        return textField
    }()
    
    let commentButton: UIButton = {
        let button = UIButton(type: UIButtonType.system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Send", for: UIControlState.normal)
        
        return button
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
