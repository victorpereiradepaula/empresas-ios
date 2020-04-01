//
//  LoginViewModel.swift
//  empresas-ios
//
//  Created by Victor Pereira on 31/03/20.
//  Copyright © 2020 Victor Pereira. All rights reserved.
//

import RxSwift
import RxCocoa

final class LoginViewModel: LoginViewModelProtocol {
    
    let emailRelay = BehaviorRelay<String?>(value: nil)
    let passwordRelay = BehaviorRelay<String?>(value: nil)
    
    private let apiClient = APIClient()
    private let disposeBag = DisposeBag()
    private let canShowErrorSubject = BehaviorSubject<Bool>(value: false)
    private let apiErrorRelay = BehaviorSubject<String?>(value: nil)
    
    var emailError: Observable<String?> {
        Observable.combineLatest(emailRelay, canShowErrorSubject)
            .map { (email, canShow) in
                guard canShow else { return nil }
                
                if let email = email, !email.isEmpty {
                    return nil
                }
                return "Informe o email"
            }
    }
    var passwordError: Observable<String?> {
        Observable.combineLatest(passwordRelay, apiErrorRelay, canShowErrorSubject)
            .map { (password, apiError, canShow) in
                guard canShow else { return nil }
                
                if let password = password, !password.isEmpty {
                    return nil
                } else if let apiError = apiError {
                    return apiError
                }
                return "Informe a senha"
        }
    }
    
    func didTapLoginButton() {
        canShowErrorSubject.onNext(true)
        guard let email = emailRelay.value, let password = passwordRelay.value else { return }
        
        let loginRequest = LoginRequest(email: email, password: password)
        
        let requestObservable: Observable<User> = apiClient.send(apiRequest: loginRequest).do(onNext: { (user) in
            print(user)
        }, onError: { (error) in
            print(error.localizedDescription)
            })
        
        requestObservable.subscribe()
        .disposed(by: disposeBag)
    }
}
