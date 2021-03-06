//
//  TextField.swift
//  empresas-ios
//
//  Created by Victor Pereira on 30/03/20.
//  Copyright © 2020 Victor Pereira. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

// MARK: TextFieldProtocol
protocol TextFieldProtocol {
    
    var placeholder: String { get }
    var keyboardType: UIKeyboardType { get }
    var isSecureTextEntry: Driver<Bool> { get }
    var delegate: UITextFieldDelegate? { get }
    var textRelay: BehaviorRelay<String?> { get }
    var placeholderColor: Driver<UIColor> { get }
    var errorMessage: Driver<String?> { get }
    var textFieldBorderColor: Driver<UIColor> { get }
    var textFieldImage: Driver<UIImage?> { get }
    var textFieldImageColor: Driver<UIColor?> { get }
    
    func didTapTextFieldRightView()
}

// MARK: TextField
final class TextField: UIView {
    
    private lazy var placeholderLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .rubikRegular(size: 14)
        label.textAlignment = .left
        return label
    }()
    
    private lazy var textField: UITextField = {
       let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .backgroundGray
        textField.font = .rubikLight(size: 16)
        textField.textColor = .gray
        textField.layer.cornerRadius = 4
        textField.layer.borderWidth = 1
        return textField
    }()
    
    private lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .rubikLight(size: 12)
        label.textAlignment = .right
        label.textColor = .red
        return label
    }()
    
    private let disposeBag = DisposeBag()
    private let viewModel: TextFieldProtocol
    
    init(viewModel: TextFieldProtocol) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setupConstraints()
        
        textField.setPadding()
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func bind() {
        textField.keyboardType = viewModel.keyboardType
        placeholderLabel.text = viewModel.placeholder
        
        if let delegate = viewModel.delegate {
            textField.delegate = delegate
        }
        
        viewModel.isSecureTextEntry
            .drive(textField.rx.isSecureTextEntry)
            .disposed(by: disposeBag)
        
        textField.rx.text
            .bind(twoWay: viewModel.textRelay)
            .disposed(by: disposeBag)
        
        viewModel.placeholderColor
            .drive(onNext: { [weak self] (textColor) in
                self?.placeholderLabel.textColor = textColor
            })
            .disposed(by: disposeBag)
        
        viewModel.errorMessage
            .drive(errorLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.textFieldBorderColor
            .drive(onNext: { [weak self] (borderColor) in
                self?.textField.layer.borderColor = borderColor.cgColor
            })
            .disposed(by: disposeBag)
        
        Driver.combineLatest(viewModel.textFieldImage, viewModel.textFieldImageColor)
            .drive(onNext: { [weak self] (image, color) in
                self?.textField.setRightView(image: image, color: color) { [weak self] in
                    self?.viewModel.didTapTextFieldRightView()
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func setupConstraints() {
        addSubview(placeholderLabel)
        addSubview(textField)
        addSubview(errorLabel)
        
        addConstraints([
            placeholderLabel.topAnchor.constraint(equalTo: topAnchor),
            placeholderLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 4),
            placeholderLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -4),
            textField.topAnchor.constraint(equalTo: placeholderLabel.bottomAnchor, constant: 4),
            textField.leftAnchor.constraint(equalTo: leftAnchor),
            textField.rightAnchor.constraint(equalTo: rightAnchor),
            textField.heightAnchor.constraint(equalToConstant: 48),
            errorLabel.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 4),
            errorLabel.leftAnchor.constraint(equalTo: placeholderLabel.leftAnchor),
            errorLabel.rightAnchor.constraint(equalTo: placeholderLabel.rightAnchor),
            errorLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
