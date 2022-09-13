//
//  JKOPaymentStrategy.swift
//  KKPayment
//
//  Created by Spock on 2022/9/13.
//

import Foundation
import PromiseKit

public class JKOPaymentStrategy: PaymentChannelStrategy {
    
    public var id: String
    
    public static var pmchCodeForB2CServer = "JKO"
    
    public var paymentName: String
    
    public var pmchCode: String
    
    public var receiveMethod: String
    
    public var is3D: Bool
    
    public var isHRP: String
    
    public var shouldProvideKKCreditCardEnterView: Bool
    
    public var shouldProvidePaymentCreditCardEnterVC: Bool
    
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
    
    required public init?(initParameters: PaymentStrategyInitializeParameters) {
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
    
    public func makePayment<T>(auth: T, userSelectedCurrency: Currency, orderData: PaymentService.OrderData, cartItemsData: PaymentService.ProductData, paymentStatusLogGroupId: Int?, paymentPagePresenter: PaymentPagePresentDelegate) -> Promise<Void> {
        firstly {
            paymentFlowEventDelegate?.paymentFlowBegin(event: .dataPrepareStart)
            
            let parameter = PaymentJKOPaymentParameter(
                auth: auth,
                payment: self,
                orderData: orderData,
                cartItemsData: cartItemsData,
                userSelectedCurrency: userSelectedCurrency,
                paymentStatusLogGroupId: paymentStatusLogGroupId
            )
            
            paymentFlowEventDelegate?.paymentFlowExecuting(event: .prepareToCallPaymentAuthAPI)
            return callPaymentJKOPaymentWebAPI(with: parameter)
            paymentFlowEventDelegate?.paymentFlowBegin(event: .dataPrepareDone)
        }
    }
    
    public func isPaymentAppOrServiceSupported() -> Bool {
        <#code#>
    }
}
