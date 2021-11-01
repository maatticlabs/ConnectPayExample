//
//  PayMethodItem.swift
//  ConnectPayExample
//
//  Created by 김진규 on 2021/06/07.
//

import Foundation
import TossPaymentsCore

struct PayMethodItem: ItemType {
    let vendorText: String
    let idText: String
    let method: PayableMethodInterface?
    let isSelected: Bool
}
