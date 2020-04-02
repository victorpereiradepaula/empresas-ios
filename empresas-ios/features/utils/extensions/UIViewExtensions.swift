//
//  UIViewExtensions.swift
//  empresas-ios
//
//  Created by Victor Pereira on 02/04/20.
//  Copyright © 2020 Victor Pereira. All rights reserved.
//

import UIKit

// Thanks Akshay Khadke - https://stackoverflow.com/questions/51498097/how-to-make-curve-top-for-uiview-in-swift
extension UIView {
    
    func setBottomCurve() {
        let size = bounds.size
        let origin = bounds.origin
        
        let height = size.height
        let width = size.width
        let x = origin.x
        let y = origin.y
        let offset = height/1.4
        
        let rectBounds = CGRect(x: x, y: y, width: width, height: height/2)
        let rectPath = UIBezierPath(rect: rectBounds)
        let ovalBounds = CGRect(x: x - offset/2, y: y, width: width + offset, height: height)
        
        let ovalPath = UIBezierPath(ovalIn: ovalBounds)
        rectPath.append(ovalPath)
        
        let maskLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.path = rectPath.cgPath
        self.layer.mask = maskLayer
    }
}
