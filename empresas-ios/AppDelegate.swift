//
//  AppDelegate.swift
//  empresas-ios
//
//  Created by Victor Pereira on 30/03/20.
//  Copyright © 2020 Victor Pereira. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    private var appRouter: AppRouter?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        guard #available(iOS 13.0, *) else {
            
            let window = UIWindow(frame: UIScreen.main.bounds)
            appRouter = AppRouter(window: window)
            
            self.window = window
            return true
        }
        
        return true
    }
}
