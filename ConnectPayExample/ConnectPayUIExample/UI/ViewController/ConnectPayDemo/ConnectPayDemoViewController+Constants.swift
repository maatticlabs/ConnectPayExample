//
//  ConnectPayDemoViewController+Constants.swift
//  ConnectPayExample
//
//  Created by 김진규 on 2021/06/03.
//

import Foundation

struct DemoInfo {
    let clientKey: String
    
    // 시크릿 키는 클라이언트에서 사용하지 않아야만 하는 키
    let secretKey: String
    let baseURL: URL
}
extension ConnectPayDemoViewController {
    enum Constants {
        static let redirectURL = ""
        
        static let devDemoInfo = DemoInfo(
            clientKey: "test_ck_OEP59LybZ8Bdv6A1JxkV6GYo7pRe",
            secretKey: "test_ak_ZORzdMaqN3wQd5k6ygr5AkYXQGwy",
            baseURL: URL(string: "https://px.dev.tosspayments.com/")!
        )
        static let stagingDemoInfo = DemoInfo(
            clientKey: "test_ck_OEP59LybZ8Bdv6A1JxkV6GYo7pRe",
            secretKey: "test_ak_ZORzdMaqN3wQd5k6ygr5AkYXQGwy",
            baseURL: URL(string: "https://api.tosspayments.com/")!
        )
        static let liveDemoInfo = DemoInfo(
            clientKey: "live_ck_YZ1aOwX7K8mvJjAkRjB3yQxzvNPG",
            secretKey: "live_sk_OALnQvDd2VJb9qA40APVMj7X41mN",
            baseURL: URL(string: "https://api.tosspayments.com/")!
        )
    }
}
