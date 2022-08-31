//
//  PaymentFlowEventDelegate.swift
//  KKPayment
//
//  Created by Spock on 2022/8/31.
//

import Foundation

protocol PaymentFlowEventDelegate: AnyObject {
    func begin(event: PaymentFlowBeginEvent)    
    func executing(event: PaymentFlowExecutingEvent)
    func cancelled()
    func completed()
}

enum PaymentFlowBeginEvent {
    case start
    case done
}

// TODO
enum PaymentFlowExecutingEvent {
    
}
