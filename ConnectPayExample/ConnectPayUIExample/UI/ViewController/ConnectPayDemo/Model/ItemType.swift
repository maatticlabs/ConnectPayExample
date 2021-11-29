//
//  ItemType.swift
//  ConnectPayExample
//
//  Created by 김진규 on 2021/06/07.
//

import Foundation
import ConnectPayCore

protocol ItemType {}

extension CardMethod: ItemType {}
extension AccountMethod: ItemType {}
