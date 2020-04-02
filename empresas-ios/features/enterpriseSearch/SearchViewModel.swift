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
    private let responseSubject = PublishSubject<[Enterprise]>()
    private var startRequestSubject = PublishSubject<EnterprisesRequest>()
    
    var request: Observable<Void> {
        startRequestSubject
            .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
            .flatMap { [unowned self] (request) -> Observable<EnterpriseArray> in
                self.apiClient.send(apiRequest: request)
        }
        .map { [weak self] (enterpriseArray) -> Void in
            self?.responseSubject.onNext(enterpriseArray.enterprises)
            return ()
        }
    }
    
    var enterprises: Driver<[Enterprise]> {
        responseSubject.asDriver(onErrorJustReturn: [])
    }
    
    var searchMessage: Driver<String?> {
        responseSubject.map { return $0.isEmpty ? "Nenhum resultado encontrado" : nil }
            .asDriver(onErrorJustReturn: nil)
    }
    
    var resultsFoundMessage: Driver<String?> {
        responseSubject.map { (results) in
            guard !results.isEmpty else { return nil }
            let count = results.count
            if count == 1 {
                return "01 resultado encontrado"
            }
            return String(format: "%02d resultados encontrados", count)
        }
        .asDriver(onErrorJustReturn: nil)
    }
    
    func searchBy(text: String?) {
        guard let text = text, !text.isEmpty else { return }
        
        let request = EnterprisesRequest(name: text)
        startRequestSubject.onNext(request)
    }
    
    func colorTo(index: Int) -> UIColor {
        if index % 2 == 0 {
            return .lightOrange
        } else if index % 3 == 0 {
            return .lightGreen
        } else {
            return .lightBlue
        }
    }
}
