//
//  ViewController.swift
//  ConnectPayWebInterface
//
//  Created by 김진규 on 2021/11/26.
//  Copyright © 2021 com.tosspayments. All rights reserved.
//

import WebKit
import ConnectPayBase
import BiometricInterface
import OCRInterface

final class ConnectPayWebInterfaceDemoViewController: UIViewController {
    lazy var webView: WKWebView = {
        let webView = WKWebView()
        
        return webView
    }()
    var messageHandler: WKScriptMessageHandler?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(webView)
        webView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.topAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        webView.load(URLRequest(url: URL(string: "https://toss.im")!))
        
        installAppBridges()
    }
}

extension ConnectPayWebInterfaceDemoViewController: WebViewControllerType {
    func installAppBridges() {
        let messageHandler = WebScriptMessageHandler()
        messageHandler.controller = self
        messageHandler.register(appBridge: HasBiometricAuthAppBridge(allowedURLHostNameList: ["toss.im"]))
        messageHandler.register(appBridge: GetBiometricAuthMethodsAppBridge(allowedURLHostNameList: ["toss.im"]))
        messageHandler.register(appBridge: VerifyBiometricAuthAppBridge(allowedURLHostNameList: ["toss.im"]))
        messageHandler.register(appBridge: RegisterBiometricAuthAppBridge(allowedURLHostNameList: ["toss.im"]))
        messageHandler.register(appBridge: ScanOCRCardAppBridge(allowedURLHostNameList: ["toss.im"]))
        
        webView.configuration.userContentController.add(messageHandler, name: "connectPayWebViewAction")
        
        self.messageHandler = messageHandler
    }
}