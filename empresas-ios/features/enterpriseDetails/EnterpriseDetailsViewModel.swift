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
    
    init(enterprise: Enterprise) {
        self.enterprise = enterprise
        
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
    
    var photo: Driver<URL?> {
        enterpriseDetails
            .map { (enterpriseDetails) in
                guard let photoPath = enterpriseDetails.enterprise?.photo, let url = URL(string: "https://empresas.ioasys.com.br/api/\(photoPath)") else { return nil }
                return url
            }
            .asDriver(onErrorJustReturn: nil)
        
    }
}
