//
//  PaymentAdditionalSetting.swift
//  KKPayment
//
//  Created by Spock on 2022/8/31.
//

import Foundation

/// Customized third-party settings
public enum PaymentAdditionalSetting {
    case stripe(publicKey: String)
    case tapPay(appId: String, appKey: String, isSandbox: Bool)
    case adyen(publicKey: String, isComponents: Bool, methods: Data)
    case none
}
