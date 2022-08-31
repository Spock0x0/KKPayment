//
//  PaymentChannelStrategy.swift
//  KKPayment
//
//  Created by Spock on 2022/8/31.
//

import Foundation
import PromiseKit

/// Description
/// pmchCodeForB2CServer: call B2C API
/// pmchCode: response from B2C API
/// is3D: is payment channel should using 3D verify
/// isHRP: is this channel for High Risk Product, e.g. Y, N
protocol PaymentChannelStrategy {
    var id: String { get }
    
    static var pmchCodeForB2CServer: String { get }
        
    var pmchCode: String { get }
    
    var receiveMethod: String { get }
    
    var is3D: Bool { get }
        
    var isHRP: String  { get }
    
    var currency: Currency  { get }
    
    var displayTextLocalizeKey: String { get }
    
    var displayImages: [UIImage?] { get }
    
    var additionalSetting: PaymentAdditionalSetting  { get }
    
    var encryptedData: Data?  { get set }
    
    var card: CreditCard? { get set }

    var paymentFlowEventDelegate: PaymentFlowEventDelegate? { get set }

    init?(initParameters: PaymentStrategyInitializeParameters)
    
    // TODO
    func makePayment(
    ) -> Promise<Void>
}

struct PaymentStrategyInitializeParameters {
    public var id: String
    
    public let pmchCode: String
    
    public let receiveMethod: String
    
    public var is3D: Bool
    
    public var isHRP: String
    
    public var currency: Currency
    
    public var additionalSettingDictionary: JsonDictionary
    
    public var encryptedData: Data?
    
    public weak var paymentFlowEventDelegate: PaymentFlowEventDelegate?
}
