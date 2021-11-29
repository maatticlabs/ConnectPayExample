//
//  AppDelegate.swift
//  ConnectPayUIExample
//
//  Created by 김진규 on 2021/11/25.
//  Copyright © 2021 com.tosspayments. All rights reserved.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let window = UIWindow()
        let navigationController = UINavigationController(rootViewController: ConnectPayDemoViewController())
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        self.window = window
            
        return true
    }
}
