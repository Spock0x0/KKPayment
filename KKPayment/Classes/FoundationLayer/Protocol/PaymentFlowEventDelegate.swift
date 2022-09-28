//
//  PaymentFlowEventDelegate.swift
//  KKPayment
//
//  Created by Spock on 2022/8/31.
//

import Foundation

public protocol PaymentFlowEventDelegate: AnyObject {
    func begin(event: PaymentFlowBeginEvent)    
    func executing(event: PaymentFlowExecutingEvent)
    func cancelled()
    func completed()
}

public enum PaymentFlowBeginEvent {
    case start
    case done
}

public enum PaymentFlowExecutingEvent {
    case prepareToCallPaymentAuthAPI
    case didGetPaymentAuthData
    case prepareRedirectToPay
    case didGetResponseFromThirdParty
    case prepareToCallPaymentReturnAPI
    case didGetPaymentReturnData
}
