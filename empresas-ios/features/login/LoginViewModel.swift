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

    #if DEBUG
    let emailRelay = BehaviorRelay<String?>(value: "testeapple@ioasys.com.br")
    let passwordRelay = BehaviorRelay<String?>(value: "12341234")
    #else
    let emailRelay = BehaviorRelay<String?>(value: nil)
    let passwordRelay = BehaviorRelay<String?>(value: nil)
    #endif
    
    private let viewStateSubject = BehaviorSubject<ViewState>(value: .normal)
    
    private let apiClient = APIClient()
    private let disposeBag = DisposeBag()
    private let canShowErrorSubject = BehaviorSubject<Bool>(value: false)
    private let apiErrorSubject = BehaviorSubject<String?>(value: nil)
    
    var emailError: Observable<String?> {
        Observable.combineLatest(emailRelay, apiErrorSubject, canShowErrorSubject)
            .map { (email, apiError, canShow) in
                guard canShow else { return nil }
                
                if apiError != nil {
                    return ""
                } else if let email = email, !email.isEmpty {
                    return nil
                }
                return "Informe o email"
        }
    }
    
    var passwordError: Observable<String?> {
        Observable.combineLatest(passwordRelay, apiErrorSubject, canShowErrorSubject)
            .map { (password, apiError, canShow) in
                guard canShow else { return nil }
                
                if let apiError = apiError {
                    return apiError
                } else if let password = password, !password.isEmpty {
                    return nil
                }
                return "Informe a senha"
        }
    }
    
    var viewState: Driver<ViewState> {
        viewStateSubject.asDriver(onErrorJustReturn: .normal)
    }
    
    func didTapLoginButton() {
        apiErrorSubject.onNext(nil)
        canShowErrorSubject.onNext(true)
        guard let email = emailRelay.value, let password = passwordRelay.value, !email.isEmpty, !password.isEmpty else { return }
        viewStateSubject.onNext(.loading)
        let loginRequest = LoginRequest(email: email, password: password)
        
        let requestObservable: Observable<User> = apiClient.send(apiRequest: loginRequest)
        
        requestObservable
            .subscribe(onNext: { [weak self] _ in
                self?.viewStateSubject.onNext(.normal)
            }, onError: { [weak self] (error) in
                self?.apiErrorSubject.onNext(error.localizedDescription)
                self?.viewStateSubject.onNext(.normal)
            })
            .disposed(by: disposeBag)
    }
}
