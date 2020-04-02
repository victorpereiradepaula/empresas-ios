//
//  User.swift
//  empresas-ios
//
//  Created by Victor Pereira on 30/03/20.
//  Copyright © 2020 Victor Pereira. All rights reserved.
//

struct User: CodableModelProtocol {
    
    let investor: Investor?
    let enterprise: Enterprise?
    let errors: [String]?
}
