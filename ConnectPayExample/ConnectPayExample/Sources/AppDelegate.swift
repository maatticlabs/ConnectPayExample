//
//  AppDelegate.swift
//  TossPaymentsConnectPay
//
//  Created by 김진규 on 2021/04/14.
//

import UIKit

@UIApplicationMain
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
