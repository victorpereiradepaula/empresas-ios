//
//  EnterpriseDetailsViewController.swift
//  empresas-ios
//
//  Created by Victor Pereira on 31/03/20.
//  Copyright © 2020 Victor Pereira. All rights reserved.
//

import UIKit

protocol EnterpriseDetailsViewModelProtocol {
    
}

final class EnterpriseDetailsViewController: UIViewController {
    
    private lazy var customBackButton = UIBarButtonItem(image: .backIcon, style: .plain, target: self, action: #selector(popViewController))
    
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
        applyLayout()
    }
    
    private func applyLayout() {
        navigationItem.leftBarButtonItem = customBackButton
        
        view.backgroundColor = .white
    }
    
    @objc private func popViewController() {
        navigationController?.popViewController(animated: true)
    }
}
