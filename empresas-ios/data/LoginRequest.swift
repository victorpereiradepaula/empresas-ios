//
//  LoginRequest.swift
//  empresas-ios
//
//  Created by Victor Pereira on 31/03/20.
//  Copyright © 2020 Victor Pereira. All rights reserved.
//

struct LoginRequest: APIRequest {
    
    var method: RequestType = .POST
    var path: String = "users/auth/sign_in"
    var parameters: [String: String]

    init(email: String, password: String) {
        parameters = [
            "email": email,
            "password": password
        ]
    }
}
