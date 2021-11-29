//
//  Section.swift
//  ConnectPayExample
//
//  Created by 김진규 on 2021/06/03.
//

import Foundation
import ConnectPayCore

enum SectionType {
    case product
    case destination
    case payMethod
}

struct Section {
    let title: String
    let type: SectionType
    let items: [ItemType]
    let handler: (() -> Void)?
    
    init(
        title: String,
        type: SectionType,
        items: [ItemType],
        handler: (() -> Void)? = nil
    ) {
        self.title = title
        self.type = type
        self.items = items
        self.handler = handler
    }
}

extension Section {
    static var placeholder: [Section] {
        return [
            Section(
                title: "장바구니",
                type: .product,
                items: [
                    ProductItem(
                        title: "토스 티셔츠",
                        amountText: "1,900 원",
                        sizeText: "사이즈: L"
                    )
                ]
            ),
            Section(
                title: "배송지",
                type: .destination,
                items: [
                    DestinationItem(
                        addressText: """
                            서울특별시 강남구 역삼동 647-9
                            한국 지식재산센터 15층 (06133)
                            """,
                        customerText: "김토스 (010-1234-1234)")
                ]
            )
        ]
    }

    static func makeSections(
        paymentMethods: PaymentMethods?,
        selectedPaymentMethodID: String?,
        settingHandler: (() -> Void)?
    ) -> [Section] {
        var sections = placeholder
        
        var items = [PayMethodItem]()
        
        if let paymentMethods = paymentMethods {
            items.append(
                contentsOf: paymentMethods.result.cards.map { card in
                    return PayMethodItem(
                        vendorText: card.cardCompany,
                        idText: card.cardNumber,
                        method: card,
                        isSelected: selectedPaymentMethodID == card.id
                    )
                }
            )
            items.append(
                contentsOf: paymentMethods.result.accounts.map{ account in
                    return PayMethodItem(
                        vendorText: account.bank,
                        idText: account.accountNumber,
                        method: account,
                        isSelected: selectedPaymentMethodID == account.id
                    )
                }
            )
        }
        items.append(
            PayMethodItem(
                vendorText: "+",
                idText: "새로운 결제 수단 추가",
                method: nil,
                isSelected: false
            )
        )
        
        sections.append(
            Section(
                title: "간편 결제",
                type: .payMethod,
                items: items,
                handler: settingHandler
            )
        )
        return sections

    }
}
