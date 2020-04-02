//
//  EnterpriseTableViewCell.swift
//  empresas-ios
//
//  Created by Victor Pereira on 31/03/20.
//  Copyright © 2020 Victor Pereira. All rights reserved.
//

import UIKit

protocol EnterpriseCellViewModelProtocol {
    
    var name: String { get }
    var enterpriseViewBackgroundColor: UIColor { get }
}

final class EnterpriseTableViewCell: UITableViewCell {

    private lazy var enterpriseView: EnterpriseView = {
        let view = EnterpriseView(name: "", image: nil, backgroundColor: .black)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 4
        return view
    }()
    
    func populateWith(viewModel: EnterpriseCellViewModelProtocol) {
        enterpriseView.setValues(name: viewModel.name, image: nil, backgroundColor: viewModel.enterpriseViewBackgroundColor)
        setupConstraints()
        applyLayout()
    }
    
    private func setupConstraints() {
        addSubview(enterpriseView)
        
        addConstraints([
            enterpriseView.topAnchor.constraint(equalTo: topAnchor),
            enterpriseView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            enterpriseView.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            enterpriseView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
    }
    
    private func applyLayout() {
        backgroundColor = .white
        selectedBackgroundView = UIView()
    }
}
