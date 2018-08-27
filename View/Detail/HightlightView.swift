//
//  HightlightView
//  Review
//
//  Created by MAC OS on 8/27/18.
//  Copyright © 2018 MAC OS. All rights reserved.
//

import UIKit
import Cosmos

class HightlightView: BaseCell {
    
    let shapeLayer = CAShapeLayer()
    
    override func setupViews() {
        super.setupViews()
        backgroundColor = UIColor.init(white: 1, alpha: 0.33)

        setupUnderLineView()
        setupRatingView()
        setupCosmosView()
        setRatingAnimation(value: 0.74)
    }
    
    var detailViewController: DetailViewController?
    
    let yourRatingLabel: UILabel = {
        let label = UILabel()
        label.text = "Your rating"
        label.textColor = UIColor.green
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.textAlignment = .center
        
        return label
    }()
    
    let cosmosView: CosmosView = {
        let view = CosmosView()
//        view.text = "Your rating"
        view.settings.updateOnTouch = true
        
        view.settings.fillMode = .full
        view.settings.starSize = 25
        view.settings.starMargin = 5
        view.settings.filledColor = UIColor.green
        view.settings.emptyBorderColor = UIColor.green
        view.settings.filledBorderColor = UIColor.green
        
        return view
    }()
    
    let pointLabel: UILabel = {
        let label = UILabel()
        label.text = "7.4"
        label.textColor = UIColor.green
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        
        return label
    }()
    
    let underLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray
        
        return view
    }()
    
    private func setupCosmosView() {
        addSubview(cosmosView)
        cosmosView.frame = CGRect(x: frame.width * 3/4 - 90, y: 100, width: 100, height: 80)
        
        addSubview(yourRatingLabel)
        yourRatingLabel.frame = CGRect(x: frame.width * 3/4 - 100, y: 70, width: 150, height: 31)
    }
    
    private func setupRatingView() {
        let center = CGPoint(x: 100, y: 100)//center
        
        // create my track layer
        let trackLayer = CAShapeLayer()
        
        let circularPath = UIBezierPath(arcCenter: center, radius: 50, startAngle: -CGFloat.pi / 2, endAngle: 1.5 * CGFloat.pi, clockwise: true)
        trackLayer.path = circularPath.cgPath
        
        trackLayer.strokeColor = UIColor.lightGray.cgColor
        trackLayer.lineWidth = 10
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.lineCap = kCALineCapRound
        layer.addSublayer(trackLayer)
        
        //        let circularPath = UIBezierPath(arcCenter: center, radius: 100, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi, clockwise: true)
        shapeLayer.path = circularPath.cgPath
        
        shapeLayer.strokeColor = UIColor.green.cgColor
        shapeLayer.lineWidth = 10
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineCap = kCALineCapRound
        
        shapeLayer.strokeEnd = 0
        
        layer.addSublayer(shapeLayer)
        

        
        addSubview(pointLabel)
        pointLabel.frame = CGRect(x: 75, y: 75, width: 50, height: 50)
    }
    
    private func setRatingAnimation(value: Float) {
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        
        basicAnimation.toValue = value
        
        basicAnimation.duration = 0.5
        
        basicAnimation.fillMode = kCAFillModeForwards
        basicAnimation.isRemovedOnCompletion = false
        
        shapeLayer.add(basicAnimation, forKey: "urSoBasic")
        pointLabel.text = String(value * 10)
    }
    
    func setupUnderLineView() {
        addSubview(underLineView)
        underLineView.frame = CGRect(x: 20, y: 170, width: frame.width - 40, height: 1)
    }
}











