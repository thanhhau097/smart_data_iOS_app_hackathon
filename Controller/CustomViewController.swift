//
//  CustomViewController.swift
//  Review
//
//  Created by MAC OS on 8/26/18.
//  Copyright © 2018 MAC OS. All rights reserved.
//

import UIKit

class CustomViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(backgroundImageView)
        backgroundImageView.frame = view.frame
    }
    
    let backgroundImageView = UIImageView(image: UIImage(named: "background"))

}
