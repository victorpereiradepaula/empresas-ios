//
//  TwoWayDataBind.swift
//  empresas-ios
//
//  Created by Victor Pereira on 31/03/20.
//  Copyright © 2020 Victor Pereira. All rights reserved.
//

import RxSwift
import RxCocoa

extension ControlPropertyType {
   
   func bind(twoWay relay: BehaviorRelay<Element>) -> Disposable {
      
      let relayToProperty = relay
         .asObservable()
         .bind(to: self)
      
      let propertyToRelay = self.subscribe(onNext: { n in
         relay.accept(n)
      }, onCompleted: {
         relayToProperty.dispose()
      })
      
      return CompositeDisposable(relayToProperty, propertyToRelay)
   }
}
