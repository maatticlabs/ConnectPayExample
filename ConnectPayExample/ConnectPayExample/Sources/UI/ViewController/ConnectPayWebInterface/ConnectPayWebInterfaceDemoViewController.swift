//
//  ConnectPayWebInterfaceDemoViewController.swift
//  ConnectPayExample
//
//  Created by 김진규 on 2021/11/15.
//  Copyright © 2021 com.tosspayments. All rights reserved.
//

import UIKit
import WebKit
import ConnectPayCore

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

extension ConnectPayWebInterfaceDemoViewController: ConnectPayAppBridgeController {}
