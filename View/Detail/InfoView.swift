//
//  InfoView.swift
//  Review
//
//  Created by MAC OS on 8/27/18.
//  Copyright © 2018 MAC OS. All rights reserved.
//

import UIKit

class InfoView: BaseCell {
    override func setupViews() {
        super.setupViews()
        backgroundColor = UIColor.init(white: 1, alpha: 0.33)

        addSubview(imageView)
        addConstraintsWithFormat("H:|[v0]|", views: imageView)
        addConstraintsWithFormat("V:|[v0(200)]", views: imageView)
        
        addSubview(nameLabel)
        addConstraintsWithFormat("H:|-16-[v0]|", views: nameLabel)
        nameLabel.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -29).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 21).isActive = true
        
        addSubview(typeLabel)
        addConstraintsWithFormat("H:|-16-[v0]|", views: typeLabel)
        typeLabel.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -4).isActive = true
        typeLabel.heightAnchor.constraint(equalToConstant: 21).isActive = true
        
        addSubview(underLineView_1)
        addConstraintsWithFormat("H:|[v0]|", views: imageView)
        underLineView_1.bottomAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
        underLineView_1.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        addSubview(addressLabel)
        addConstraintsWithFormat("H:|-16-[v0]|", views: addressLabel)
        addressLabel.topAnchor.constraint(equalTo: underLineView_1.bottomAnchor, constant: 8).isActive = true
        addressLabel.heightAnchor.constraint(equalToConstant: 21).isActive = true
        
        addSubview(addressContentLabel)
        addConstraintsWithFormat("H:|-16-[v0]|", views: addressContentLabel)
        addressContentLabel.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 4).isActive = true
        addressContentLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        addSubview(underLineView_2)
        addConstraintsWithFormat("H:|[v0]|", views: underLineView_2)
        underLineView_2.bottomAnchor.constraint(equalTo: addressContentLabel.bottomAnchor, constant: 8).isActive = true
        underLineView_2.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        addSubview(phoneLabel)
        phoneLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        phoneLabel.topAnchor.constraint(equalTo: underLineView_2.bottomAnchor, constant: 4).isActive = true
        phoneLabel.heightAnchor.constraint(equalToConstant: 21).isActive = true
        phoneLabel.rightAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        addSubview(phoneContentLabel)
        phoneContentLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        phoneContentLabel.topAnchor.constraint(equalTo: phoneLabel.bottomAnchor, constant: 8).isActive = true
        phoneContentLabel.heightAnchor.constraint(equalToConstant: 21).isActive = true
        phoneContentLabel.rightAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        addSubview(websiteLabel)
        websiteLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: 0).isActive = true
        websiteLabel.topAnchor.constraint(equalTo: underLineView_2.bottomAnchor, constant: 4).isActive = true
        websiteLabel.heightAnchor.constraint(equalToConstant: 21).isActive = true
        websiteLabel.leftAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        addSubview(websiteContentLabel)
        websiteContentLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: 0).isActive = true
        websiteContentLabel.topAnchor.constraint(equalTo: websiteLabel.bottomAnchor, constant: 8).isActive = true
        websiteContentLabel.heightAnchor.constraint(equalToConstant: 21).isActive = true
        websiteContentLabel.leftAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        addSubview(underLineView_3)
        addConstraintsWithFormat("H:|[v0]|", views: underLineView_3)
        underLineView_3.bottomAnchor.constraint(equalTo: websiteContentLabel.bottomAnchor, constant: 8).isActive = true
        underLineView_3.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        addSubview(QRCodeButton)
        QRCodeButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        QRCodeButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        QRCodeButton.topAnchor.constraint(equalTo: underLineView_3.bottomAnchor, constant: 8).isActive = true
        QRCodeButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        addSubview(underLineView_4)
        addConstraintsWithFormat("H:|[v0]|", views: underLineView_4)
        underLineView_4.bottomAnchor.constraint(equalTo: QRCodeButton.bottomAnchor, constant: 8).isActive = true
        underLineView_4.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        addSubview(recommendationLabel)
        addConstraintsWithFormat("H:|-16-[v0]|", views: recommendationLabel)
        recommendationLabel.topAnchor.constraint(equalTo: underLineView_4.bottomAnchor, constant: 8).isActive = true
        recommendationLabel.heightAnchor.constraint(equalToConstant: 21).isActive = true
        
        QRCodeButton.addTarget(self, action: #selector(showQRCodeImage), for: UIControlEvents.touchUpInside)
//        QRCodeButton.
        
        setupRecommendationCollectionView()
    }
    
    
    
    let recommendationCollectionView = RecommendationCollectionView()
    
    func setupRecommendationCollectionView() {
        addSubview(recommendationCollectionView)
        addConstraintsWithFormat("H:|[v0]|", views: recommendationCollectionView)
        recommendationCollectionView.topAnchor.constraint(equalTo: recommendationLabel.bottomAnchor, constant: 8).isActive = true
        recommendationCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true

    }
    
    @objc func generateQRCode(_ string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)
        
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3)
            
            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }
        
        return nil
    }
    
    @objc func showQRCodeImage() {
        let id = detailViewController?.id
        if let id = id, let image = generateQRCode(id) {
            addSubview(blurBackgroundView)
            addConstraintsWithFormat("H:|[v0]|", views: blurBackgroundView)
            addConstraintsWithFormat("V:|[v0]|", views: blurBackgroundView)
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
            blurBackgroundView.addGestureRecognizer(tap)
            
            addSubview(qrCodeImageView)
            qrCodeImageView.image = image
            qrCodeImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
            qrCodeImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
            qrCodeImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
            qrCodeImageView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        }
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        // handling code
        blurBackgroundView.removeFromSuperview()
        qrCodeImageView.removeFromSuperview()
    }
    
    let qrCodeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    let blurBackgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.init(white: 0, alpha: 0.33)
        
        return view
    }()
    
    
    
    var detailViewController: DetailViewController?
    
    let imageView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.text = "Benh vien Thanh Nhan"
        
        return label
    }()
    
    let typeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = UIColor.gray
        label.text = "Benh vien"
        
        return label
    }()
    
    let underLineView_1: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.gray
        
        return view
    }()
    
    let addressLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.text = "Address"
        
        return label
    }()
    
    let addressContentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "Hai Ba Trung, Ha Noi"
        label.numberOfLines = 0
        return label
    }()
    
    let underLineView_2: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.gray
        
        return view
    }()
    
    
    let directionButton: UIButton = {
        let button = UIButton(type: UIButtonType.system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        button.backgroundColor = UIColor.green
        button.setTitle("Direction", for: UIControlState.normal)
        
        return button
    }()
    
    let phoneLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.text = "Phone"
        label.textAlignment = .center
        return label
    }()
    
    let phoneContentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.gray
        label.text = "0987654356"
        label.textAlignment = .center
        
        return label
    }()
    
    let websiteLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.text = "Website"
        label.textAlignment = .center
        
        return label
    }()
    
    let websiteContentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.gray
        label.text = "placeholder.com"
        label.textAlignment = .center
        
        return label
    }()
    
    let underLineView_3: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.gray
        
        return view
    }()
    
    let QRCodeButton: UIButton = {
        let button = UIButton(type: UIButtonType.system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        button.backgroundColor = UIColor.green
        button.setTitle("QR Code", for: UIControlState.normal)
        button.setTitleColor(UIColor.white, for: UIControlState.normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        
        return button
    }()
    
    let underLineView_4: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.gray
        
        return view
    }()
    
    let recommendationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.text = "Recommendation"
        
        return label
    }()

}









