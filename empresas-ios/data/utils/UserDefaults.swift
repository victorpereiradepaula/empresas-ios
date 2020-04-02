//
//  UserDefaults.swift
//  empresas-ios
//
//  Created by Victor Pereira on 31/03/20.
//  Copyright © 2020 Victor Pereira. All rights reserved.
//

import Foundation

extension UserDefaults {
    
    enum SessionKeys: String {
        case client
        case accessToken
        case uid
    }
    
    func getUserSession() -> UserSession? {
        guard let client = value(forKey: SessionKeys.client.rawValue) as? String,
            let accessToken = value(forKey: SessionKeys.accessToken.rawValue) as? String,
            let uid = value(forKey: SessionKeys.uid.rawValue) as? String else { return nil }
        return UserSession(client: client, accessToken: accessToken, uid: uid)
    }
    
    func setUserSession(_ userSession: UserSession) {
        set(userSession.client, forKey: SessionKeys.client.rawValue)
        set(userSession.accessToken, forKey: SessionKeys.accessToken.rawValue)
        set(userSession.uid, forKey: SessionKeys.uid.rawValue)
        synchronize()
    }
    
    func removeUserSession() {
        removeObject(forKey: SessionKeys.client.rawValue)
        removeObject(forKey: SessionKeys.accessToken.rawValue)
        removeObject(forKey: SessionKeys.uid.rawValue)
        synchronize()
    }
}
