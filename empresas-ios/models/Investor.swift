//
//  Investor.swift
//  empresas-ios
//
//  Created by Victor Pereira on 30/03/20.
//  Copyright © 2020 Victor Pereira. All rights reserved.
//

struct Investor: Codable {
    
    let id: Int
    let investorName: String
    let email: String
    let city: String
    let country: String
    let balance: Float
    let photo: String
    let portfolio: Portfolio
    let portfolioValue: Float
    let firstAccess: Bool
    let superAngel: Bool
}
