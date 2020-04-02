//
//  TextFieldViewModel.swift
//  empresas-ios
//
//  Created by Victor Pereira on 31/03/20.
//  Copyright © 2020 Victor Pereira. All rights reserved.
//

import RxSwift
import RxCocoa

// MARK: TextFieldType
enum TextFieldType {
    case email, password
    
    var placeholder: String {
        switch self {
        case .email:
            return "Email"
        case .password:
            return "Senha"
        }
    }
    
    var isSecureTextEntryRelay: Bool {
        switch self {
        case .password:
            return true
        default:
            return false
        }
    }
}

// MARK: TextFieldViewModel
final class TextFieldViewModel {
    
    let placeholder: String
    let textRelay: BehaviorRelay<String?>
    weak var delegate: UITextFieldDelegate?
    private let error: Observable<String?>
    private let type: TextFieldType
    private let isSecureTextEntryRelay: BehaviorRelay<Bool>
    
    init(type: TextFieldType, textRelay: BehaviorRelay<String?>, error: Observable<String?>, delegate: UITextFieldDelegate) {
        self.type = type
        self.placeholder = type.placeholder
        self.textRelay = textRelay
        self.error = error
        self.delegate = delegate
        self.isSecureTextEntryRelay = BehaviorRelay(value: type.isSecureTextEntryRelay)
    }
}

// MARK: TextFieldProtocol
extension TextFieldViewModel: TextFieldProtocol {
    
    var isSecureTextEntry: Driver<Bool> {
        isSecureTextEntryRelay.asDriver(onErrorJustReturn: false)
    }
    
    var keyboardType: UIKeyboardType {
        switch type {
        case .email:
            return .emailAddress
        case .password:
            return .default
        }
    }

    var placeholderColor: Driver<UIColor> {
        .just(.gray)
    }
    
    var errorMessage: Driver<String?> {
        error.asDriver(onErrorJustReturn: nil)
    }
    
    var textFieldBorderColor: Driver<UIColor> {
        error.map { $0 == nil ? .backgroundGray : .red }
            .asDriver(onErrorJustReturn: .backgroundGray)
    }
    
    var textFieldImage: Driver<UIImage?> {
        Observable.combineLatest(error, isSecureTextEntryRelay)
            .map { [weak self] (error, isSecureTextEntry) in
                if error != nil {
                    return .errorIcon
                }
                
                if self?.type == .password {
                    return isSecureTextEntry ? .eyeIcon : .eyeIconOff
                }
                return nil
            }
            .asDriver(onErrorJustReturn: nil)
    }
    
    var textFieldImageColor: Driver<UIColor?> {
        error.map { $0 == nil ? .gray : .red }
            .asDriver(onErrorJustReturn: .gray)
    }
    
    func didTapTextFieldRightView() {
        switch type {
        case .password:
            isSecureTextEntryRelay.accept(!isSecureTextEntryRelay.value)
        default:
            break
        }
    }
}
