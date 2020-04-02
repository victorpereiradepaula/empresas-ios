//
//  SessionManager.swift
//  empresas-ios
//
//  Created by Victor Pereira on 31/03/20.
//  Copyright © 2020 Victor Pereira. All rights reserved.
//

import RxSwift
import RxCocoa

enum State: Equatable {
    case unauthenticated
    case loggedIn(userSession: UserSession)
    
    static func == (lhs: State, rhs: State) -> Bool {
        switch (lhs, rhs) {
        case (.loggedIn, .loggedIn),
             (.unauthenticated, .unauthenticated):
            return true
        default:
            return false
        }
    }
}

final class SessionManager {
    
    private let stateRelay: BehaviorRelay<State>
    static let shared = SessionManager()
    
    private init() {
        if let userSession = UserDefaults.standard.getUserSession() {
            stateRelay = BehaviorRelay(value: .loggedIn(userSession: userSession))
        } else {
            stateRelay = BehaviorRelay(value: .unauthenticated)
        }
    }
    
    var state: Driver<State> {
        stateRelay.asDriver()
    }
    
    var userSession: UserSession? {
        guard case .loggedIn(let userSession) = stateRelay.value else { return nil }
        return userSession
    }
    
    func updateSession(_ userSession: UserSession) {
        UserDefaults.standard.setUserSession(userSession)
        stateRelay.accept(.loggedIn(userSession: userSession))
    }
    
    func removeSession() {
        UserDefaults.standard.removeUserSession()
        stateRelay.accept(.unauthenticated)
    }
}
