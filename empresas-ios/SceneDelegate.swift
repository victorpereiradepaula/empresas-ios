//
//  SceneDelegate.swift
//  empresas-ios
//
//  Created by Victor Pereira on 30/03/20.
//  Copyright © 2020 Victor Pereira. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    @available(iOS 13.0, *)
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = LoginViewController(nibName: "LoginViewController", bundle: nil)
        window.makeKeyAndVisible()
        
        self.window = window
    }
}
