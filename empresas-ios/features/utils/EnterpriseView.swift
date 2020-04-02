//
//  EnterpriseView.swift
//  empresas-ios
//
//  Created by Victor Pereira on 01/04/20.
//  Copyright © 2020 Victor Pereira. All rights reserved.
//

import UIKit

final class EnterpriseView: UIView {
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .clear
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .rubikBold(size: 18)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    init(name: String, image: UIImage?, backgroundColor: UIColor) {
        super.init(frame: .zero)
        setupConstraints()
        setValues(name: name, image: image, backgroundColor: backgroundColor)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setValues(name: String, image: UIImage?, backgroundColor: UIColor) {
        self.backgroundColor = backgroundColor
        nameLabel.text = name
        imageView.image = image
    }
    
    private func setupConstraints() {
        addSubview(imageView)
        addSubview(nameLabel)
        
        addConstraints([
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 34),
            imageView.heightAnchor.constraint(equalToConstant: 32),
            imageView.widthAnchor.constraint(equalToConstant: 32),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            nameLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            nameLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -34),
            heightAnchor.constraint(equalToConstant: 120)
        ])
    }
}
