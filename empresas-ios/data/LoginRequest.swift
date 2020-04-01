//
//  LoginRequest.swift
//  empresas-ios
//
//  Created by Victor Pereira on 31/03/20.
//  Copyright © 2020 Victor Pereira. All rights reserved.
//

struct LoginRequest: APIRequest {
    
    var method: RequestType
    var path: String
    var parameters: [String: String]

    init(email: String, password: String) {
        method = .POST
        path = "users/auth/sign_in"
        parameters = [
            "email": email,
            "password": password
        ]
    }
}
