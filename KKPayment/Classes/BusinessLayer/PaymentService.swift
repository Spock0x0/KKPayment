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
    
    /// public interactive interface
    /// call payment/booking/channels and return available channels
    public func getPaymentChannels() -> [PaymentChannel] {
        // actually call api get channel
        return processPaymentChannels()
    }
    
    public func createPaymentChannelStrategy(parameters: PaymentStrategyInitializeParameters) -> PaymentChannelStrategy? {
        return strategyMapper.getStrategy(initParameter: parameters)
    }
    
    private func register<Strategy: PaymentChannelStrategy>(with strategyType: Strategy.Type) {
        strategyMapper.register(with: strategyType.pmchCodeForB2CServer) { parameters in
            strategyType.init(initParameters: parameters)
        }
    }
    
    /// add strategy to paymentChannel
    private func processPaymentChannels() -> [PaymentChannel] {
        
        // Mock param
        // get from API in real case
        let param: PaymentStrategyInitializeParameters = PaymentStrategyInitializeParameters(
            id: "mockId",
            pmchCode: "JKO_TWD",
            receiveMethod: "ONLINE_JKO",
            is3D: false,
            isHRP: "N",
            currency: .twd,
            additionalSettingDictionary: [:],
            acceptedCardTypes: [.visa],
            paymentFlowEventDelegate: nil)
        
        // use pmchCode to get strategy
        let strategy = createPaymentChannelStrategy(parameters: param)
        
        do {
            return [try PaymentChannel(id: param.id,
                                   pmchCode: param.pmchCode,
                                   is3D: param.is3D,
                                   isHRP: param.isHRP,
                                   currency: param.currency,
                                   receiveMethod: param.receiveMethod,
                                   acceptedCardTypes: ["VISA"],
                                   setting: param.additionalSettingDictionary,
                                   strategy: strategy)]
        } catch {
            fatalError("process payment channels fail")
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
