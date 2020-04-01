//
//  EnterpriseDetailsViewModel.swift
//  empresas-ios
//
//  Created by Victor Pereira on 31/03/20.
//  Copyright © 2020 Victor Pereira. All rights reserved.
//

import Foundation

final class EnterpriseDetailsViewModel: EnterpriseDetailsViewModelProtocol {
    
    private let enterprise: Enterprise
    
    init(enterprise: Enterprise) {
        self.enterprise = enterprise
    }
}
