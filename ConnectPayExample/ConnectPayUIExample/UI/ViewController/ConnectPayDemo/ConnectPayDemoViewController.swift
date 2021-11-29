//
//  ConnectPayDemoViewController.swift
//  TossPaymentsConnectPay
//
//  Created by 김진규 on 2021/04/14.
//

import UIKit
import ConnectPayCore
import TossPaymentsCore
import WebKit

class ConnectPayDemoViewController: UIViewController {
    lazy var session: URLSession = URLSession(configuration: .ephemeral)
    
    enum GetAccessTokenError: Error {
        case noCustomerToken
        case invalidAPIURL
        case unknown
    }
    
    var demoInfo: DemoInfo = Constants.stagingDemoInfo {
        didSet {
            ConnectPay.baseURL = demoInfo.baseURL
            refreshConnectPay()
        }
    }
    
    var customerKey: String = UserDefaults.standard.string(forKey: "CustomerKey") ?? "Default" {
        didSet {
            UserDefaults.standard.setValue(customerKey, forKey: "CustomerKey")
            refreshConnectPay()
        }
    }
    
    func refreshConnectPay() {
        self.connectPay = ConnectPay(
            clientKey: demoInfo.clientKey,
            customerKey: customerKey,
            redirectURL: Constants.redirectURL
        )
        
        connectPay?.delegate = self
        refreshPayMethods()
    }
    
    lazy var connectPay: ConnectPay? = ConnectPay(
        clientKey: demoInfo.clientKey,
        customerKey: customerKey,
        redirectURL: Constants.redirectURL
    )
    
    lazy var viewHolder: ViewHolder = ViewHolder()
    
    var selectedPayableMethod: PayableMethodInterface?
    var sections: [Section] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        connectPay?.delegate = self
        
        viewHolder.installView(on: view)
        setupCollectionView()
        setupButtons()
        setupNavigationBarButton()
        
        refreshPayMethods()
    }
    
    
    func setupButtons() {
        viewHolder.button.addTarget(self, action: #selector(didTapConfirmButton(_:)), for: .touchUpInside)
    }
    
    func setupNavigationBarButton() {
        let rightBarButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(didClickRightBarButtonItem(_:)))
        navigationItem.rightBarButtonItem = rightBarButton
    }
    
    @objc func didClickRightBarButtonItem(_ sender: Any) {
        let alertController = UIAlertController(title: "설정", message: nil, preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "테스트 타겟 변경", style: .default, handler: { _ in
            self.showChangeTestTargetAlert()
        }))
        alertController.addAction(UIAlertAction(title: "CustomerKey 변경", style: .default, handler: { _ in
            self.showChangeCustomerKey()
        }))
        alertController.addAction(UIAlertAction(title: "금액 변경", style: .default, handler: { _ in

        }))
        alertController.addAction(UIAlertAction(title: "웹뷰 테스트", style: .default, handler: { _ in
            let viewController = ConnectPayWebInterfaceDemoViewController()
            self.navigationController?.pushViewController(viewController, animated: true)
        }))
        
        present(alertController, animated: true)
    }
        
    func showChangeTestTargetAlert() {
        let alertController = UIAlertController(title: "테스트 타겟 변경", message: nil, preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Dev 서버 - Dev Key", style: .default, handler: { _ in
            self.demoInfo = Constants.devDemoInfo
        }))
        alertController.addAction(UIAlertAction(title: "Live 서버 - Dev Key", style: .default, handler: { _ in
            self.demoInfo = Constants.stagingDemoInfo
        }))
        alertController.addAction(UIAlertAction(title: "Live 서버 - Live Key", style: .default, handler: { _ in
            self.demoInfo = Constants.liveDemoInfo
        }))
        
        present(alertController, animated: true)
    }
    
    func showChangeCustomerKey() {
        let alertController = UIAlertController(title: "CustomerKey 변경", message: "CustomerKey를 세팅해주세요.", preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.text = self.customerKey
        }
        alertController.addAction(UIAlertAction(title: "확인", style: .default, handler: { action in
            let customerKey = alertController.textFields?.first?.text ?? "Default"
            self.customerKey = customerKey
        }))
        present(alertController, animated: true, completion: nil)
    }
    
    func refreshPayMethods(
        selectedMethodID: String? = nil,
        paymentMethods: PaymentMethods? = nil
    ) {
        if let paymentMethods = paymentMethods {
            handlePaymentMethods(paymentMethods: paymentMethods)
        } else {
            getPaymentMethods { [weak self] result in
                switch result {
                case let .success(paymentMethods):
                    self?.handlePaymentMethods(paymentMethods: paymentMethods)
                case .failure:
                    self?.handlePaymentMethods()
                }
            }
        }
    }
    
    private func handlePaymentMethods(
        paymentMethods: PaymentMethods? = nil
    ) {
        let sections = Section.makeSections(
            paymentMethods: paymentMethods,
            selectedPaymentMethodID: selectedPayableMethod?.id ?? paymentMethods?.result.selectedMethodID,
            settingHandler: { [weak self] in
                self?.openSettings()
            }
        )
        self.sections = sections
        self.viewHolder.collectionView.reloadData()
    }
}

extension ConnectPayDemoViewController {
    @objc func didTapConfirmButton(_ sender: Any) {
        if selectedPayableMethod != nil {
            requestPayment()
        } else {
            addPaymentMethod()
        }
    }
    
    @objc func didTapAddPaymentMethod(_ sender: Any) {
        addPaymentMethod()
    }
}
