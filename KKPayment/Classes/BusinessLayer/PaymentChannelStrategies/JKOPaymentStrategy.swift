//
//  JKOPaymentStrategy.swift
//  KKPayment
//
//  Created by Spock on 2022/9/13.
//

import Foundation
import PromiseKit
import WebKit

public class JKOPaymentStrategy: NSObject, PaymentChannelStrategy {
    
    public var id: String
    
    public static var pmchCodeForB2CServer = "JKO"
    
    public var paymentName: String = "JKO"
    
    public var pmchCode: String
    
    public var receiveMethod: String
    
    public var is3D: Bool
    
    public var isHRP: String
    
    public var shouldProvideKKCreditCardEnterView: Bool = false
    
    public var shouldProvidePaymentCreditCardEnterVC: Bool = false
    
    public var currency: Currency
    
    public var displayTextLocalizeKey: String {
        return "order_label_confirm_mobile_jkos_pay"
    }
    
    public var displayImages: [UIImage?] {
        return [UIImage(named: "icPaymentJkOpay")]
    }
    
    public var additionalSetting: PaymentAdditionalSetting
    
    public var encryptedData: Data?
    
    public var card: CreditCard?
    
    public var acceptedCardTypes: [CreditCardType]
        
    public var paymentFlowEventDelegate: PaymentFlowEventDelegate?
    
    public required init?(initParameters: PaymentStrategyInitializeParameters) {
        self.id = initParameters.id
        self.pmchCode = initParameters.pmchCode
        self.receiveMethod = initParameters.receiveMethod
        self.is3D = initParameters.is3D
        self.isHRP = initParameters.isHRP
        self.currency = initParameters.currency
        self.additionalSetting = .none
        self.encryptedData = initParameters.encryptedData
        self.acceptedCardTypes = initParameters.acceptedCardTypes
        self.paymentFlowEventDelegate = initParameters.paymentFlowEventDelegate
    }
    
    public func makePayment() {
        // TODO
        print("JKO make payment")
    }
    
    public func paymentResponse() {
        // TODO
        print("payment response")
    }
    
}
