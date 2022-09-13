//
//  PaymentService.swift
//  KKPayment
//
//  Created by Spock on 2022/9/13.
//

import Foundation

public class PaymentService {
    public typealias RegisterCode = String

    private var strategyMapper = PaymentChannelStrategyMapper()
    
    /// if create new payment, need register here
    public init () {
        register(with: JKOPaymentStrategy.self)
    }
    
    public func getAllRegisteredPaymentCode() -> [RegisterCode] {
        strategyMapper.getAllRegisteredCodes()
    }
    
    public func createPaymentChannelStrategy(parameters: PaymentStrategyInitializeParameters) -> PaymentChannelStrategy? {
        return strategyMapper.getStrategy(initParameter: parameters)
    }
    
    private func register<Strategy: PaymentChannelStrategy>(with strategyType: Strategy.Type) {
        strategyMapper.register(with: strategyType.pmchCodeForB2CServer) { paramters in
            strategyType.init(initParameters: paramters)
        }
    }

}

public extension PaymentService {
    struct ProductData {
        let oids: [String]
        let mids: [String]
        let goDates: [Date]?
        
        public init(oids: [String], mids: [String], goDates: [Date]?) {
            self.oids = oids
            self.mids = mids
            self.goDates = goDates
        }
    }
    
    struct OrderData {
        let masterMid: String
        let amount: String
        
        public init(masterMid: String, amount: String) {
            self.masterMid = masterMid
            self.amount = amount
        }
    }
}
