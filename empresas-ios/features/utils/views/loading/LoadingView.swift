//
//  LoadingView.swift
//  empresas-ios
//
//  Created by Victor Pereira on 02/04/20.
//  Copyright © 2020 Victor Pereira. All rights reserved.
//

import UIKit

enum ViewState {
    case normal
    case loading
}

final class LoadingView: UIView {
    
    private lazy var activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.color = .lightPink
        activityIndicatorView.startAnimating()
        activityIndicatorView.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicatorView
    }()
    
    init() {
        super.init(frame: .zero)
        
        applyLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    #if DEBUG
    deinit {
        print("dealloc ---> \(String(describing: type(of: self)))")
    }
    #endif
    
    private func applyLayout() {
        backgroundColor = .clearGray
        
        addSubview(activityIndicatorView)
        addConstraints([
            activityIndicatorView.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
