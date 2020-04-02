//
//  LoadingView.swift
//  empresas-ios
//
//  Created by Victor Pereira on 02/04/20.
//  Copyright © 2020 Victor Pereira. All rights reserved.
//

import UIKit

// MARK: ViewStare
enum ViewState {
    case normal
    case loading
}

// MARK: LoadingView
final class LoadingView: UIView {
    
    private lazy var loadIndicatorView: LoadIndicatorView = {
        let loadIndicatorView = LoadIndicatorView(frame: .zero)
        loadIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        return loadIndicatorView
    }()
    
    private lazy var smallLoadingIndicator: LoadIndicatorView = {
        let loadIndicatorView = LoadIndicatorView(frame: .zero)
        loadIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        return loadIndicatorView
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
        
        addSubview(loadIndicatorView)
        addSubview(smallLoadingIndicator)
        
        addConstraints([
            loadIndicatorView.centerXAnchor.constraint(equalTo: centerXAnchor),
            loadIndicatorView.centerYAnchor.constraint(equalTo: centerYAnchor),
            loadIndicatorView.heightAnchor.constraint(equalToConstant: 72),
            loadIndicatorView.widthAnchor.constraint(equalToConstant: 72),
            smallLoadingIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            smallLoadingIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
            smallLoadingIndicator.heightAnchor.constraint(equalToConstant: 47),
            smallLoadingIndicator.widthAnchor.constraint(equalToConstant: 47)
        ])
        
        loadIndicatorView.rotate(clockWise: true)
        smallLoadingIndicator.rotate(clockWise: false)
    }
}
