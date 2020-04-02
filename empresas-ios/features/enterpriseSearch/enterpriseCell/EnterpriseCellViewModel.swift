//
//  EnterpriseCellViewModel.swift
//  empresas-ios
//
//  Created by Victor Pereira on 01/04/20.
//  Copyright © 2020 Victor Pereira. All rights reserved.
//

import UIKit

final class EnterpriseCellViewModel: EnterpriseCellViewModelProtocol {
    
    let name: String
    let enterpriseViewBackgroundColor: UIColor
    
    init(enterprise: Enterprise, enterpriseViewBackgroundColor: UIColor) {
        self.name = enterprise.enterpriseName
        self.enterpriseViewBackgroundColor = enterpriseViewBackgroundColor
    }
}
