//
//  EnterprisesRequest.swift
//  empresas-ios
//
//  Created by Victor Pereira on 31/03/20.
//  Copyright © 2020 Victor Pereira. All rights reserved.
//

import Foundation

struct EnterprisesRequest: APIRequest {
    
    var method: RequestType = .GET
    var path: String = "enterprises"
    var parameters: [String: String]
    
    /// Search enterprises by name
    init(name: String) {
        parameters = ["name": name]
    }
    
    /// Get a enterprise
    init(id: Int) {
        path.append("/\(id)")
        parameters = [:]
    }
}
