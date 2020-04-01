//
//  Enterprise.swift
//  empresas-ios
//
//  Created by Victor Pereira on 30/03/20.
//  Copyright © 2020 Victor Pereira. All rights reserved.
//

struct EnterpriseArray: Codable {
    
    let enterprises: [Enterprise]
}

struct EnterpriseDetails: Codable {
    
    let enterprise: Enterprise
}

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
    let shares: Int?
    let sharePrice: Float
    let ownShares: Int?
    let city: String
    let country: String
    let enterpriseType: EnterpriseType
}
