//
//  TextFieldViewModel.swift
//  empresas-ios
//
//  Created by Victor Pereira on 31/03/20.
//  Copyright © 2020 Victor Pereira. All rights reserved.
//

import RxSwift
import RxCocoa

final class TextFieldViewModel {
    
    private let error: Observable<String?>
    let placeholder: String
    weak var delegate: UITextFieldDelegate?
    
    init(placeholder: String, error: Observable<String?>, delegate: UITextFieldDelegate) {
        self.placeholder = placeholder
        self.error = error
        self.delegate = delegate
    }
}

// MARK: TextFieldProtocol
extension TextFieldViewModel: TextFieldProtocol {

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
        .just(.eyeIcon)
    }
    
    var textFieldImageColor: Driver<UIColor?> {
        error.map { $0 == nil ? .gray : .red }
            .asDriver(onErrorJustReturn: .gray)
    }
}
