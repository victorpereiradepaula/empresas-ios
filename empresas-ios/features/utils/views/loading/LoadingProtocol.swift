//
//  LoadingProtocol.swift
//  empresas-ios
//
//  Created by Victor Pereira on 02/04/20.
//  Copyright © 2020 Victor Pereira. All rights reserved.
//

import UIKit

protocol LoadingProtocol {
    var loadingView: LoadingView? { get }
    
    func setViewState(viewState: ViewState)
    func allocLoadingView(_ loadingView: LoadingView)
    func deallocLoadingView()
}

extension LoadingProtocol where Self: UIViewController {
    
    private func showLoading() {
        guard loadingView == nil else { return }
        let loadingView = LoadingView()
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loadingView)
        
        view.addConstraints([
            loadingView.topAnchor.constraint(equalTo: view.topAnchor),
            loadingView.leftAnchor.constraint(equalTo: view.leftAnchor),
            loadingView.rightAnchor.constraint(equalTo: view.rightAnchor),
            loadingView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        allocLoadingView(loadingView)
    }
    
    private func hideLoading() {
        loadingView?.removeFromSuperview()
        deallocLoadingView()
    }
    
    internal func setViewState(viewState: ViewState) {
        switch viewState {
        case .normal:
            hideLoading()
        case .loading:
            showLoading()
        }
    }
}
