//
//  UITextFieldExtension.swift
//  empresas-ios
//
//  Created by Victor Pereira on 31/03/20.
//  Copyright © 2020 Victor Pereira. All rights reserved.
//

import UIKit
import RxSwift
import RxGesture

extension UITextField {
    
    func setPadding() {
        let height = frame.size.height
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: 14, height: height))
        leftViewMode = .always
        
        rightView = UIView(frame: CGRect(x: 0, y: 0, width: 14, height: height))
        rightViewMode = .always
    }
    
    func setRightView(image: UIImage?, color: UIColor?, action: @escaping (() -> ())) {
        let height = frame.size.height
        if let image = image, let color = color {
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: height))
            imageView.image = image
            imageView.contentMode = .center
            
            let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 32, height: height))
            containerView.addSubview(imageView)
            rightView = containerView
            rightViewMode = .always
            tintColor = color
            
            _ = imageView.rx.tapGesture()
                .when(.recognized)
                .takeUntil(rx.deallocated)
                .bind { _ in action() }
            
        } else {
            rightView = UIView(frame: CGRect(x: 0, y: 0, width: 14, height: height))
            rightViewMode = .always
        }
    }
}
