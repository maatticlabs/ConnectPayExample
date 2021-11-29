//
//  ConnectPayDemoViewController+ConnectPay.swift
//  ConnectPayExample
//
//  Created by 김진규 on 2021/06/03.
//

import UIKit
import ConnectPayCore

// MARK: - ConnectPay
extension ConnectPayDemoViewController {
    func getPaymentMethods(methodsHandler: @escaping (Result<PaymentMethods, Error>) -> Void) {
        connectPay?.getPaymentMethods(on: self, methodsHandler: methodsHandler)
    }
    
    func addPaymentMethod(_ method: String? = nil) {
        connectPay?.addPaymentMethod(method, on: self) { [weak self] result in
            switch result {
            case let .success(selectedMethodID):
                self?.refreshPayMethods(selectedMethodID: selectedMethodID)
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
    
    func requestPayment() {
        let data = makePaymentData()
        connectPay?.requestPayment(data: data, on: self) { result in
            switch result {
            case let .success(paymentKey):
                print(paymentKey)
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
    
    func openSettings() {
        connectPay?.openSettings(on: self)
    }
    
    func setupPassword() {
        connectPay?.setupPassword(on: self) { [weak self] result in
            switch result {
            case .success:
                self?.refreshPayMethods()
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
    
    func setupOneTouchPay() {
        connectPay?.setupOneTouchPay(on: self)
    }
    
    func requestAgreemnt() {
        connectPay?.requestAgreement(terms: "빌링", on: self) { [weak self] result in
            switch result {
            case .success:
                self?.refreshPayMethods()
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
}

extension ConnectPayDemoViewController {
    func makePaymentData() -> PaymentData {
        return PaymentData(
            amount: 1900000,
            orderID: UUID().uuidString,
            orderName: "토스 티셔츠 외 2건",
            successURL: "https://example.com/payment/success",
            failURL: "https://example.com/payment/fail",
            methodID: selectedPayableMethod?.id
        )
    }
}

extension ConnectPayDemoViewController: ConnectPayDelegate {
    func didChangedPaymentMethods(_ paymentMethods: PaymentMethods?) {
        refreshConnectPay()
    }
    
    // 토큰 받아오는 구현
    func getAccessToken(
        code: String?,
        resultHandler: ((Result<Bool, Error>) -> Void)?
    ) {
        guard let code = code else {
            resultHandler?(.failure(GetAccessTokenError.noCustomerToken))
            return
        }
        guard let url = URL(string: "https://api.tosspayments.com/v1/connectpay/authorizations/access-token") else {
            resultHandler?(.failure(GetAccessTokenError.invalidAPIURL))
            return
        }
        let data = (demoInfo.secretKey + ":").data(using: .utf8)
        let encodedString = data?.base64EncodedString()
        let authorizationHeader = "Basic \(encodedString ?? "")"
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let body = [
            "code": code,
            "customerKey": customerKey,
            "grantType": "AuthorizationCode"
        ]
        let jsonbody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        request.httpBody = jsonbody
        request.allHTTPHeaderFields = [
            "Content-Type": "application/json",
            "Content-Length": "\(request.httpBody?.count ?? 0)",
            "Authorization": authorizationHeader
        ]
        print("URL: \(request.url!)")
        print("METHOD: \(request.httpMethod ?? "")")
        print("HEADER: \(request.allHTTPHeaderFields ?? [:])\n")
        print("BODY: \(body)\n")
        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                DispatchQueue.main.async {
                    resultHandler?(.failure(error))
                }
                return
            }
            
            if let response = response as? HTTPURLResponse,
               response.statusCode >= 200, response.statusCode < 300 {
                DispatchQueue.main.async {
                    resultHandler?(.success(true))
                }
                return
            }
            
            DispatchQueue.main.async {
                resultHandler?(.failure(GetAccessTokenError.unknown))
            }
        }
        
        task.resume()
    }
}
