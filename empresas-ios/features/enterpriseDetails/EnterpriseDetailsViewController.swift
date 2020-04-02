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
    var photo: Driver<URL?> { get }
}

final class EnterpriseDetailsViewController: UIViewController {
    
    private lazy var customBackButton = UIBarButtonItem(image: .backIcon, style: .plain, target: self, action: #selector(popViewController))
    
    private lazy var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .cyan
        return imageView
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .rubikLight(size: 18)
        label.textAlignment = .justified
        label.numberOfLines = 0
        label.textColor = .black
        return label
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
        view.addSubview(photoImageView)
        view.addSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            photoImageView.leftAnchor.constraint(equalTo: view.leftAnchor),
            photoImageView.rightAnchor.constraint(equalTo: view.rightAnchor),
            photoImageView.heightAnchor.constraint(equalToConstant: 120),
            descriptionLabel.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: 24),
            descriptionLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            descriptionLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16)
        ])
    }
    
    private func bind() {
        
        viewModel.description
            .drive(descriptionLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.photo
            .drive(onNext: { [weak self] (url) in
                if let photoURL = url {
                    self?.photoImageView.load(url: photoURL)
                }
            })
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

extension UIImageView {
    
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
