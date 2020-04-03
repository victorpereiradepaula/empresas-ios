//
//  LoadIndicatorView.swift
//  empresas-ios
//
//  Created by Victor Pereira on 02/04/20.
//  Copyright © 2020 Victor Pereira. All rights reserved.
//

import UIKit

final class LoadIndicatorView: UIView {
    
    private let indicatorColor: UIColor = .lightPink
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        let arcWidth: CGFloat = 3
        
        let center = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
        
        let radius: CGFloat = max(bounds.width, bounds.height)
        
        let startAngle: CGFloat = 3 * .pi / 4
        let endAngle: CGFloat = .pi / 4
        
        let path = UIBezierPath(arcCenter: center,
                                radius: radius/2 - arcWidth/2,
                                startAngle: startAngle,
                                endAngle: endAngle,
                                clockwise: true)
        
        path.lineWidth = arcWidth
        indicatorColor.setStroke()
        path.stroke()
    }
    
    func rotate(duration: CFTimeInterval = 7, clockWise: Bool) {
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        animation.repeatDuration = .infinity
        
        let startAngle: CGFloat = 0
        let endAgle: CGFloat = .pi * 12
        
        animation.fromValue = clockWise ? startAngle : endAgle
        animation.toValue = clockWise ? endAgle : startAngle
        animation.duration = duration
        
        layer.add(animation, forKey: nil)
    }
}
