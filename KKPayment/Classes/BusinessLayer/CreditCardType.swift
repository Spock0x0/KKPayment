//
//  CreditCardType.swift
//  KKPayment
//
//  Created by Spock on 2022/9/13.
//

import Foundation

public enum CreditCardType: String {
    case amex = "AE"
    case jcb = "JCB"
    case mastercard = "MASTERCARD"
    case visa = "VISA"
    
    public var image: UIImage? {
        switch self {
        case .amex:
            return UIImage(named: "icPaymentAmerican")
            
        case .jcb:
            return UIImage(named: "icPaymentJcb")
            
        case .mastercard:
            return UIImage(named: "icPaymentMaster")
            
        case .visa:
            return UIImage(named: "icPaymentVisa")
        }
    }
}
