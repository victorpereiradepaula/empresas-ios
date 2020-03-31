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
    
    let placeholder: String
    let textRelay: BehaviorRelay<String?>
    weak var delegate: UITextFieldDelegate?
    private let error: Observable<String?>
    private let image: UIImage?
    
    init(placeholder: String, textRelay: BehaviorRelay<String?>, error: Observable<String?>, image: UIImage?, delegate: UITextFieldDelegate) {
        self.placeholder = placeholder
        self.textRelay = textRelay
        self.error = error
        self.image = image
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
        error.map { [weak self] in return $0 == nil ? self?.image : .errorIcon }
            .asDriver(onErrorJustReturn: nil)
    }
    
    var textFieldImageColor: Driver<UIColor?> {
        error.map { $0 == nil ? .gray : .red }
            .asDriver(onErrorJustReturn: .gray)
    }
}
