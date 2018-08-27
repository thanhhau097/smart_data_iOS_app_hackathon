//
//  ViewController.swift
//  Review
//
//  Created by MAC OS on 8/27/18.
//  Copyright © 2018 MAC OS. All rights reserved.
//

import UIKit

class HomeViewController: CustomViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupSearchView()
    }
    
    let logoImageView: UIImageView = {
        let imageView = UIImageView()
//        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "logo")
        imageView.layer.masksToBounds = true
        imageView.layer.shadowOffset = CGSize(width: 10, height: 10)
//        imageView.layer.sha
        
        return imageView
    }()
    
    func setupViews() {
        view.backgroundColor = .lightGray

        
        view.addSubview(searchView)
        searchView.frame = CGRect(x: 16, y: UIScreen.main.bounds.height / 2 - 25, width: UIScreen.main.bounds.width - 32, height: 50)
        

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        view.addSubview(logoImageView)
        logoImageView.frame = CGRect(x: UIScreen.main.bounds.width / 2 - 70, y: 130, width: 140, height: 140)
    }
    
    func setupSearchView() {
        searchView.qrCodeButton.addTarget(self, action: #selector(handleQRCodeButton), for: UIControlEvents.touchUpInside)
        searchView.searchButton.addTarget(self, action: #selector(handleSearchButton), for: UIControlEvents.touchUpInside)
    }
    
    @objc func handleQRCodeButton() {
        navigationController?.pushViewController(QRScannerController(), animated: true)
    }
    
    @objc func handleSearchButton() {
        navigationController?.pushViewController(SearchViewController(), animated: true)
    }
    
    let searchView = SearchView()

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

