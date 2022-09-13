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
    
    /// for call B2C API
    static var pmchCodeForB2CServer: String { get }
    
    /// for log track
    var paymentName: String { get }

    /// response from B2C API
    var pmchCode: String { get }
    
    var receiveMethod: String { get }
    
    /// is payment channel should using 3D verify
    var is3D: Bool { get }
    
    /// is this channel for High Risk Product, e.g. Y, N
    var isHRP: String  { get }
    
    /// declare should this payment should using KKCreditCardEnterView to receive credit card information or not
    var shouldProvideKKCreditCardEnterView: Bool { get }

    /// declare should this payment should using third party component to receive credit card information or not
    var shouldProvidePaymentCreditCardEnterVC: Bool { get }

    /// for the payment channel, from backend
    var currency: Currency  { get }
    
    var displayTextLocalizeKey: String { get }
    
    var displayImages: [UIImage?] { get }
    
    var additionalSetting: PaymentAdditionalSetting  { get }
    
    var encryptedData: Data?  { get set }
    
    var card: CreditCard? { get set }
    
    var acceptedCardTypes: [CreditCardType] { get set }

    var paymentFlowEventDelegate: PaymentFlowEventDelegate? { get set }

    init?(initParameters: PaymentStrategyInitializeParameters)
    
    // TODO
    func makePayment<T>(
        auth: T,
        userSelectedCurrency: Currency,
        orderData: PaymentService.OrderData,
        cartItemsData: PaymentService.ProductData,
        paymentStatusLogGroupId: Int?,
        paymentPagePresenter: PaymentPagePresentDelegate
    ) -> Promise<Void>
    
    func isPaymentAppOrServiceSupported() -> Bool
}

public struct PaymentStrategyInitializeParameters {
    public var id: String
    
    public let pmchCode: String
    
    public let receiveMethod: String
    
    public var is3D: Bool
    
    public var isHRP: String
    
    public var currency: Currency
    
    public var additionalSettingDictionary: JsonDictionary
    
    public var encryptedData: Data?
    
    public var acceptedCardTypes: [CreditCardType]
    
    public weak var paymentFlowEventDelegate: PaymentFlowEventDelegate?
    
    init (
        id: String,
        pmchCode: String,
        receiveMethod: String,
        is3D: Bool,
        isHRP: String,
        currency: Currency,
        additionalSettingDictionary: JsonDictionary,
        encryptedData: Data? = nil,
        acceptedCardTypes: [CreditCardType],
        paymentFlowEventDelegate: PaymentFlowEventDelegate?
    ) {
        self.id = id
        self.pmchCode = pmchCode
        self.receiveMethod = receiveMethod
        self.is3D = is3D
        self.isHRP = isHRP
        self.currency = currency
        self.additionalSettingDictionary = additionalSettingDictionary
        self.encryptedData = encryptedData
        self.acceptedCardTypes = acceptedCardTypes
        self.paymentFlowEventDelegate = paymentFlowEventDelegate
    }
}
