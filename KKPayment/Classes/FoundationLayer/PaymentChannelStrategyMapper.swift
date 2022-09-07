//
//  PaymentChannelStrategyMapper.swift
//  KKPayment
//
//  Created by Spock on 2022/9/7.
//


import Foundation

struct PaymentChannelStrategyMapper {
    
    typealias PMCHCode = String
    typealias RegisterCode = String
    typealias StrategyFactory = ((PaymentStrategyInitializeParameters) -> PaymentChannelStrategy?)
    
    private var strategyFactories = [RegisterCode: StrategyFactory]()
    
    init() {}

    mutating func register(with registerCode: RegisterCode, strategyFactory: @escaping StrategyFactory) {
        strategyFactories[registerCode] = strategyFactory
    }
    
    func getStrategy(initParameter: PaymentStrategyInitializeParameters) -> PaymentChannelStrategy? {
        
        guard let registerCode = getRegisteredCode(with: initParameter.pmchCode) else {
            return nil
        }
        
        if let factory = strategyFactories[registerCode] {
            return factory(initParameter)
        }
        
        return nil
    }
    
    func getAllRegisteredCodes() -> [RegisterCode] {
        return Array(strategyFactories.keys)
    }
    
    // TODO
    // what this actually doing?
    /// Get Payment Channel Registered Code with pmchCode From Server.
    ///
    /// Take JKO payment for example:
    ///
    /// "JKO" is register code for JKO payment channel, it is pmchCodeForB2CServer.
    ///
    /// "TW_JKO_TWD" might be pmchCode from server response.
    ///
    /// The algorithm for this function is using partially match and return pmchCodeForB2CServer.
    ///
    /// - Parameter pmchCode: pmchCode from B2C server booking/channels API
    /// - Returns: payment channel register code
    func getRegisteredCode(with pmchCode: PMCHCode) -> RegisterCode? {
        
        let registeredCodes = getAllRegisteredCodes()
        
        for registeredCode in registeredCodes {
            if pmchCode.contains(registeredCode) {
                return registeredCode
            }
        }
        
        return nil
    }

}
