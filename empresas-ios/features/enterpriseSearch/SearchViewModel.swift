//
//  EnterpriseSearchViewModel.swift
//  empresas-ios
//
//  Created by Victor Pereira on 31/03/20.
//  Copyright © 2020 Victor Pereira. All rights reserved.
//

import RxSwift
import RxCocoa

final class EnterpriseSearchViewModel: EnterpriseSearchViewModelProtocol {
        
    private let apiClient = APIClient()
    let searchTextSubject = PublishSubject<String>()
    
    var enterprises: Driver<[Enterprise]> {
        searchTextSubject
            .map { EnterprisesRequest(name: $0) }
            .flatMap { request -> Observable<[Enterprise]> in
                let enterpriseArray: Observable<EnterpriseArray> = self.apiClient.send(apiRequest: request)
                return enterpriseArray.map { $0.enterprises }
            }
            .asDriver(onErrorJustReturn: [])
    }
    
    var searchMessage: Driver<String?> {
        enterprises.map { return $0.isEmpty ? "Nenhum resultado encontrado" : nil }
    }
}
