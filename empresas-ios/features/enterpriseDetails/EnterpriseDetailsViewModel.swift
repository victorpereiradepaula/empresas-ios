//
//  EnterpriseDetailsViewModel.swift
//  empresas-ios
//
//  Created by Victor Pereira on 31/03/20.
//  Copyright © 2020 Victor Pereira. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class EnterpriseDetailsViewModel: EnterpriseDetailsViewModelProtocol {
        
    private let apiClient = APIClient()
    private let enterprise: Enterprise
    private let enterpriseDetails: Observable<EnterpriseDetails>
    let enterpriseViewBackgroundColor: UIColor
    
    init(enterprise: Enterprise, enterpriseViewBackgroundColor: UIColor) {
        self.enterprise = enterprise
        self.enterpriseViewBackgroundColor = enterpriseViewBackgroundColor
        
        enterpriseDetails = apiClient.send(apiRequest: EnterprisesRequest(id: enterprise.id)).share()
    }
    
    var name: String {
        enterprise.enterpriseName
    }
    
    var description: Driver<String?> {
        enterpriseDetails
            .map { $0.enterprise?.description }
            .asDriver(onErrorJustReturn: nil)
    }
}
