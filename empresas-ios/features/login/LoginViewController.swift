//
//  LoginViewController.swift
//  empresas-ios
//
//  Created by Victor Pereira on 30/03/20.
//  Copyright © 2020 Victor Pereira. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

// MARK: LoginViewModelProtocol
protocol LoginViewModelProtocol {
    
    var emailRelay: BehaviorRelay<String?> { get }
    var passwordRelay: BehaviorRelay<String?> { get }
    var emailError: Observable<String?> { get }
    var passwordError: Observable<String?> { get }
    var viewState: Driver<ViewState> { get }
    
    func didTapLoginButton()
}

// MARK: LoginViewController
final class LoginViewController: UIViewController {
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var headerViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var welcomeLabel: UILabel!
    
    private lazy var emailTextField: TextField = {
        let textField = TextField(viewModel: TextFieldViewModel(type: .email, textRelay: viewModel.emailRelay, error: viewModel.emailError, delegate: self))
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var passwordTextField: TextField = {
        let textField = TextField(viewModel: TextFieldViewModel(type: .password, textRelay: viewModel.passwordRelay, error: viewModel.passwordError, delegate: self))
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.tintColor = .gray
        return textField
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = .rubikMedium(size: 16)
        button.setTitleColor(.white, for: .normal)
        button.setTitle("ENTRAR", for: .normal)
        button.backgroundColor = .primary
        button.layer.cornerRadius = 8
        button.tintColor = .white
        return button
    }()
    
    private let viewModel: LoginViewModelProtocol
    internal var loadingView: LoadingView?
    private let disposeBag = DisposeBag()
    
    init(viewModel: LoginViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: "LoginViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    #if DEBUG
    deinit {
        print("dealloc ---> \(Self.self)")
    }
    #endif
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
        applyLayout()
        bind()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        headerView.setBottomCurve()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    private func bind() {
        
        loginButton.rx.tap
            .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
            .bind { [weak self] in
                self?.viewModel.didTapLoginButton()
        }
        .disposed(by: disposeBag)
        
        viewModel.viewState
            .drive(onNext: { [weak self] (viewState) in
                self?.setViewState(viewState: viewState)
            })
            .disposed(by: disposeBag)
    }
    
    private func applyLayout() {
        view.backgroundColor = .white
        
        welcomeLabel.textColor = .white
        welcomeLabel.textAlignment = .center
        welcomeLabel.font = .rubikRegular(size: 20)
        welcomeLabel.text = "Seja bem vindo ao empresas!"
    }
    
    private func setupConstraints() {
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
        
        view.addConstraints([
            emailTextField.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 32),
            emailTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            emailTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor),
            passwordTextField.leftAnchor.constraint(equalTo: emailTextField.leftAnchor),
            passwordTextField.rightAnchor.constraint(equalTo: emailTextField.rightAnchor),
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 24),
            loginButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32),
            loginButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -32),
            loginButton.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
}

// MARK: UITextFieldDelegate
extension LoginViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.2) {
            self.welcomeLabel.isHidden = true
            self.headerViewHeightConstraint.constant = 150
            self.view.layoutIfNeeded()
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.welcomeLabel.isHidden = false
        self.headerViewHeightConstraint.constant = 250
    }
}

// MARK: LoadingProtocol
extension LoginViewController: LoadingProtocol {
    
    func allocLoadingView(_ loadingView: LoadingView) {
        self.loadingView = loadingView
    }
    
    func deallocLoadingView() {
        loadingView = nil
    }
}
