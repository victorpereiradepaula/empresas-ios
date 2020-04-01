//
//  AppRouter.swift
//  empresas-ios
//
//  Created by Victor Pereira on 31/03/20.
//  Copyright © 2020 Victor Pereira. All rights reserved.
//

import UIKit
import RxSwift

final class AppRouter {
    
    private let window: UIWindow
    private let disposeBag = DisposeBag()
    
    init(window: UIWindow) {
        self.window = window
        bind()
    }
    
    private func setRootWith(state: State) {
        let rootViewController: UIViewController
        
        switch state {
        case .unauthenticated:
            rootViewController = LoginViewController(viewModel: LoginViewModel())
        case .loggedIn:
            let navigationController = UINavigationController(rootViewController: EnterpriseSearchViewController())
            rootViewController = navigationController
        }

        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
    }
    
    private func bind() {
        SessionManager.shared.state
            .distinctUntilChanged()
            .drive(onNext: { [unowned self] (state) in
                self.setRootWith(state: state)
            })
            .disposed(by: disposeBag)
    }
}
