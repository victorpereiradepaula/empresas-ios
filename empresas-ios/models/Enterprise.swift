//
//  Enterprise.swift
//  empresas-ios
//
//  Created by Victor Pereira on 30/03/20.
//  Copyright © 2020 Victor Pereira. All rights reserved.
//

struct Enterprise: Codable {
    
    let id: Int
    let enterpriseName: String
    let description: String
    let emailEnterprise: String?
    let facebook: String?
    let twitter: String?
    let linkedin: String?
    let phone: String?
    let ownEnterprise: Bool
    let photo: String?
    let value: Float
    let shares: Int
    let sharePrice: Float
    let ownShares: Int
    let city: String
    let country: String
    let enterpriseType: EnterpriseType
}
