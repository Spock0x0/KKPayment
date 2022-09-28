//
//  PaymentChannel.swift
//  KKPayment
//
//  Created by Spock on 2022/9/27.
//

import Foundation

public struct PaymentChannel: Hashable {
    
    public let id: String
    public let type: PaymentType
    public let pmchCode: String
    public let is3D: Bool
    /// is this channel for High Risk Product, e.g. Y, N
    public let isHRP: String
    public let currency: Currency
    /// e.g. ONLINE_STRIPE, ONLINE_JP_STRIPE, FUBON
    public let receiveMethod: String
    public var card: CreditCard? {
        didSet {
            strategy?.updateCreditCard(with: card)
        }
    }
    public var encryptedData: Data? {
        didSet {
            strategy?.updateEncryptedData(with: encryptedData)
        }
    }
    
    /// e.g. VISA, MASTERCARD, AE
    public let acceptedCardTypes: [CreditCardType]
    
    public var strategy: PaymentChannelStrategy?
    
    public init(id: String, pmchCode: String, is3D: Bool, isHRP: String, currency: Currency, receiveMethod: String, acceptedCardTypes: [String], setting: [String: Any], strategy: PaymentChannelStrategy?) throws {
        self.id = id
        self.pmchCode = pmchCode
        self.type = try PaymentType(code: pmchCode, setting: setting)
        self.is3D = is3D
        self.isHRP = isHRP
        self.currency = currency
        self.receiveMethod = receiveMethod
        self.acceptedCardTypes = acceptedCardTypes.compactMap { CreditCardType(rawValue: $0) }
        self.strategy = strategy
    }
    
    /// Initialization only for zero payment
    ///
    /// zero payment 的 pmchCode 必需為 ""，因此直接於內部指定 PaymentType
    public init?(isZeroPayment: Bool, currency: Currency) {
        guard isZeroPayment else { return nil }
        self.id = ""
        self.type = .zero
        self.pmchCode = ""
        self.is3D = false
        self.isHRP = ""
        self.currency = currency
        self.receiveMethod = ""
        self.acceptedCardTypes = []
    }
    
    public func applying(with card: CreditCard?) -> PaymentChannel {
        var new = self
        new.card = card
        return new
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(is3D)
        hasher.combine(isHRP)
        hasher.combine(currency)
        hasher.combine(receiveMethod)
        hasher.combine(acceptedCardTypes)
        hasher.combine(card)
        hasher.combine(encryptedData)
        hasher.combine(strategy?.id)
    }
    
    public static func == (lhs: PaymentChannel, rhs: PaymentChannel) -> Bool {
        return lhs.id == rhs.id &&
            lhs.pmchCode == rhs.pmchCode &&
            lhs.type == rhs.type &&
            lhs.is3D == rhs.is3D &&
            lhs.isHRP == rhs.isHRP &&
            lhs.currency == rhs.currency &&
            lhs.receiveMethod == rhs.receiveMethod &&
            lhs.acceptedCardTypes == rhs.acceptedCardTypes &&
            lhs.card == rhs.card &&
            lhs.encryptedData == rhs.encryptedData &&
            lhs.id == rhs.id
    }
}
