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
    let searchTextSubject = PublishSubject<String?>()
    
    var enterprises: Driver<[Enterprise]> {
        searchTextSubject
            .debug()
            .distinctUntilChanged()
            .flatMapLatest { (text) -> Observable<EnterprisesRequest> in
                guard let text = text, !text.isEmpty else { return .never() }
                return .just(EnterprisesRequest(name: text))
            }
            .flatMapLatest { [weak self] request -> Observable<EnterpriseArray> in
                guard let self = self else { return .never() }
                return self.apiClient.send(apiRequest: request)
            }
            .map { $0.enterprises }
            .asDriver(onErrorJustReturn: [])
    }
    
    var searchMessage: Driver<String?> {
        enterprises.map { return $0.isEmpty ? "Nenhum resultado encontrado" : nil }
        .asDriver(onErrorJustReturn: nil)
    }
    
    var resultsFoundMessage: Driver<String?> {
        enterprises.map { (results) in
            guard !results.isEmpty else { return nil }
            let count = results.count
            if count == 1 {
                return "01 resultado encontrado"
            }
            return String(format: "%02d resultados encontrados", count)
        }
    }
}
