//
//  CreditCard.swift
//  KKPayment
//
//  Created by Spock on 2022/8/31.
//

import Foundation
import Stripe

// TODO library become pod or copy it
public struct CreditCard: Hashable {
    public init(number: String?, expYear: UInt, expMonth: UInt, cvc: String?) {
        self.number = number
        self.expYear = expYear
        self.expMonth = expMonth
        self.cvc = cvc
    }
    public var number: String?
    public var expYear: UInt = 0
    public var expMonth: UInt = 0
    public var cvc: String?
    
    public enum ThreeDSecure: String, JsonSerializeable { case required, unknown, optional }
    public var threeDSecure = ThreeDSecure.unknown
    
    // Card Token from 3rd Party service, e.g. Stripe Card Source ID
    public var tokenId: String?
    
    public var expDateString: String {
        guard expMonth > 0 else { return "" }
        
        let expMonthString = String(format: "%02d", expMonth)
        
        let expYearString: String
        if expYear > 0 {
            expYearString = String(format: "%02d", expYear)
        } else {
            expYearString = ""
        }
        
        return "\(expMonthString)/\(expYearString)"
    }
}

extension CreditCard {
    public init(_ card: STPCardParams, _ source: STPSource?) {
        self.init(number: card.number ?? "", expYear: card.expYear, expMonth: card.expMonth, cvc: card.cvc ?? "")
        self.tokenId = source?.stripeID
        if let threeDSecure = source?.cardDetails?.threeDSecure {
            self.threeDSecure = threeDSecure == .required ? .required : .optional
        }
    }
}
