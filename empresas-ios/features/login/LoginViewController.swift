//
//  LoginViewController.swift
//  empresas-ios
//
//  Created by Victor Pereira on 30/03/20.
//  Copyright © 2020 Victor Pereira. All rights reserved.
//

import UIKit

final class LoginViewController: UIViewController {
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var headerViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var welcomeLabel: UILabel!
    
    private lazy var emailTextField: TextField = {
        let textField = TextField(viewModel: TextFieldViewModel(placeholder: "Email", error: .just(nil), delegate: self))
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    private lazy var passwordTextField: TextField = {
        let textField = TextField(viewModel: TextFieldViewModel(placeholder: "Senha", error: .just("Teste"), delegate: self))
        textField.translatesAutoresizingMaskIntoConstraints = false
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
        applyLayout()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
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

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            self?.welcomeLabel.isHidden = true
            self?.headerViewHeightConstraint.constant = 200
        })
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            self?.welcomeLabel.isHidden = false
            self?.headerViewHeightConstraint.constant = 250
        })
    }
}
