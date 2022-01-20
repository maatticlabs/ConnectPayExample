//
//  AppDelegate.swift
//  ConnectPayWebInterface
//
//  Created by 김진규 on 2021/11/26.
//  Copyright © 2021 com.tosspayments. All rights reserved.
//

import UIKit
//import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
//        FirebaseApp.configure()
        
        let window = UIWindow()
        let navigationController = UINavigationController(rootViewController: ConnectPayWebInterfaceDemoViewController())
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        self.window = window
            
        return true
    }

}

