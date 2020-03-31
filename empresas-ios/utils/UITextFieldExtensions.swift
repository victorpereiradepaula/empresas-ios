//
//  UITextFieldExtensions.swift
//  empresas-ios
//
//  Created by Victor Pereira on 31/03/20.
//  Copyright © 2020 Victor Pereira. All rights reserved.
//

import UIKit

extension UITextField {
    
    func setPadding() {
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: 14, height: frame.size.height))
        leftViewMode = .always
        
        rightView = UIView(frame: CGRect(x: 0, y: 0, width: 14, height: frame.size.height))
        rightViewMode = .always
    }
    
    func setRightView(image: UIImage?, color: UIColor?) {
        if let image = image, let color = color {
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 48))
            imageView.image = image
            imageView.contentMode = .center
            
            let containerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 32, height: 48))
            containerView.addSubview(imageView)
            rightView = containerView
            rightViewMode = .always
            tintColor = color
        } else {
            rightView = UIView(frame: CGRect(x: 0, y: 0, width: 14, height: frame.size.height))
            rightViewMode = .always
        }
    }
}
