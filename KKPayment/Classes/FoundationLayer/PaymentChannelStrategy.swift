//
//  PaymentChannelStrategy.swift
//  KKPayment
//
//  Created by Spock on 2022/8/31.
//

import Foundation
import PromiseKit

public protocol PaymentChannelStrategy {
    var id: String { get }
    
    /// call B2C API
    static var pmchCodeForB2CServer: String { get }
    
    /// pmchCode which response from B2C API
    var pmchCode: String { get }
    
    var receiveMethod: String { get }
    
    /// is payment channel should using 3D verify
    var is3D: Bool { get }
    
    /// is this channel for High Risk Product, e.g. Y, N
    var isHRP: String  { get }
    
    var currency: Currency  { get }
    
    var displayTextLocalizeKey: String { get }
    
    var displayImages: [UIImage?] { get }
    
    var additionalSetting: PaymentAdditionalSetting  { get }
    
    var encryptedData: Data?  { get set }
    
//    var card: CreditCard? { get set }
//    
//    var paymentFlowEventDelegate: PaymentFlowEventDelegate? { get set }
//    
//    init?(initParameters: PaymentStrategyInitializeParameters)
    
    // TODO
    func makePayment(
    ) -> Promise<Void>
}

