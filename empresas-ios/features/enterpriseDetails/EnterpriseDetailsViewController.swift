//
//  EnterpriseDetailsViewController.swift
//  empresas-ios
//
//  Created by Victor Pereira on 31/03/20.
//  Copyright © 2020 Victor Pereira. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol EnterpriseDetailsViewModelProtocol {
    
    var name: String { get }
    var description: Driver<String?> { get }
    var enterpriseViewBackgroundColor: UIColor { get }
}

final class EnterpriseDetailsViewController: UIViewController {
    
    private lazy var customBackButton = UIBarButtonItem(image: .backIcon, style: .plain, target: self, action: #selector(popViewController))
    
    private lazy var enterpriseView: EnterpriseView = {
        let view = EnterpriseView(name: viewModel.name, image: nil, backgroundColor: viewModel.enterpriseViewBackgroundColor)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = .rubikLight(size: 18)
        textView.textAlignment = .justified
        textView.backgroundColor = .clear
        textView.isEditable = false
        textView.isSelectable = false
        textView.textColor = .black
        return textView
    }()
    
    private let disposeBag = DisposeBag()
    private let viewModel: EnterpriseDetailsViewModelProtocol
    
    init(viewModel: EnterpriseDetailsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    #if DEBUG
    deinit {
        print(self.description)
    }
    #endif
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupContraints()
        applyLayout()
        bind()
    }
    
    private func setupContraints() {
        view.addSubview(enterpriseView)
        view.addSubview(descriptionTextView)
        
        NSLayoutConstraint.activate([
            enterpriseView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            enterpriseView.leftAnchor.constraint(equalTo: view.leftAnchor),
            enterpriseView.rightAnchor.constraint(equalTo: view.rightAnchor),
            descriptionTextView.topAnchor.constraint(equalTo: enterpriseView.bottomAnchor, constant: 24),
            descriptionTextView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            descriptionTextView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            descriptionTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -24)
        ])
    }
    
    private func bind() {
        
        viewModel.description
            .drive(descriptionTextView.rx.text)
            .disposed(by: disposeBag)
    }
    
    private func applyLayout() {
        title = viewModel.name
        navigationItem.leftBarButtonItem = customBackButton
        
        view.backgroundColor = .white
    }
    
    @objc private func popViewController() {
        navigationController?.popViewController(animated: true)
    }
}
