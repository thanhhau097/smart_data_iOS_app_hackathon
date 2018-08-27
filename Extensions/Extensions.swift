//
//  Extensions.swift
//  Review
//
//  Created by MAC OS on 8/27/18.
//  Copyright © 2018 MAC OS. All rights reserved.
//

import UIKit

extension UIView {
    func addConstraintsWithFormat(_ format: String, views: UIView...) {
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }
}

var imageCache = NSCache<AnyObject, AnyObject>()

class CustomImageView: UIImageView {
    
    var imageUrlString : String?
    
    func loadImageUsing(urlString: String){
        
        imageUrlString = urlString
        
        let url = URL(string: urlString)
        image = nil
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) {
            self.image = imageFromCache as? UIImage
        }
        
        guard url != nil else {
            return
        }
        
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            if error != nil {
                print(error!)
                return
            }
            DispatchQueue.main.async {
                let imageToCache = UIImage(data: data!)
                if self.imageUrlString == urlString {
                    self.image = imageToCache
                }
                if let imageToCache = imageToCache{
                    imageCache.setObject(imageToCache, forKey: urlString as AnyObject)
                }
                
            }
        }).resume()
    }
}
