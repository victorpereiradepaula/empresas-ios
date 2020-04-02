//
//  CodableModelProtocol.swift
//  empresas-ios
//
//  Created by Victor Pereira on 01/04/20.
//  Copyright © 2020 Victor Pereira. All rights reserved.
//

protocol CodableModelProtocol: Codable {
    
    var errors: [String]? { get }
}
