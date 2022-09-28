//
//  PaymentType.swift
//  KKPayment
//
//  Created by Spock on 2022/9/27.
//

import Foundation

public enum PaymentType: String, CaseIterable, Equatable {
    
    // MARK: Stripe
    case stripeCard = "STRIPE_CREDIT_CARD"
    case stripeApplePay = "STRIPE_APPLE_PAY"
    case stripeAlipay = "STRIPE_ALI_PAY"
    case linepay = "TW_LINEPAY"
    case alipayHK = "ALIPAYHK_APP"
    case alipayCN = "ALIPAYHK_ALI_PAY_APP"
    case fubonCard = "FUBON_CREDIT_CARD"
    case tapPayCard = "TW_TAPPAY_CREDIT_CARD"
    case tapPayTravelCard = "TAPPAY_TRAVEL_CARD"
    case tapPayApplePay = "TAPPAY_APPLE_PAY"
    case adyenCard = "ADYEN_CREDIT_CARD"
    case adyenMomoWallet = "ADYEN_MOMO_PAY" // SG_ADYEN_MOMO_PAY_VND
    case adyenKCPCard = "ADYEN_KCP_CREDIT_CARD"
    case adyenGrabPay = "ADYEN_GRAB_PAY"
    case adyenUnionPay = "ADYEN_UNION_PAY"
    case jkos = "JKO" // e.g. "JKO_TWD"
    case onePay = "ONEPAY_ATM_CARD"
    case payDollar = "PAY_DOLLAR_OCTOPUS"
    case tossCard = "TOSS_CREDIT_CARD"
    case tossPay = "TOSS_TOSS_PAY"
    case atome = "ATOME"
    case zero = "ZERO"
    
    init(code: String, setting: [String: Any]?) throws {
        guard let p = PaymentType.allCases.first(where: { code.contains($0.rawValue) }) else {
            throw Error.channelInvalid(code)
        }
        self = p
    }
    
    private enum Error: Swift.Error, LocalizedError {
        case channelInvalid(_ code: String)
        
        var errorDescription: String? {
            switch self {
            case let .channelInvalid(code): return "Payment Channel \(code) is not supported"
            }
        }
    }
}

extension PaymentType {
    func getDisplayText(paymentChannels: [PaymentChannel] = []) -> String {
        switch self {
        case .adyenCard, .adyenKCPCard, .fubonCard, .stripeCard, .tapPayCard:
            return getCreditCardName(channels: paymentChannels)
            
        case .tapPayTravelCard:
            return "order_label_confirm_mobile_taiwan_traveler_card".localize("國民旅遊卡")
            
        case .stripeApplePay, .tapPayApplePay:
            return "order_label_confirm_mobile_apple_pay".localize("Apple Pay")
            
        case .stripeAlipay, .alipayCN:
            return "order_label_confirm_mobile_ali_pay".localize("支付寶")
            
        case .linepay:
            return "order_label_confirm_mobile_line_pay".localize("Line Pay")
            
        case .alipayHK:
            return "order_label_confirm_mobile_ali_pay_hk".localize("Alipay")
            
        case .adyenMomoWallet:
            return "order_label_confirm_mobile_momo_wallet".localize("MoMo E-Wallet")
            
        case .adyenGrabPay:
            return "order_label_confirm_mobile_grab_pay".localize("Grab Pay")
            
        case .jkos:
            return "order_label_confirm_mobile_jkos_pay".localize("JKO Pay")
            
        case .onePay:
            return "order_label_confirm_mobile_atm_card".localize("ATM Card")

        case .adyenUnionPay:
            return "order_label_confirm_mobile_union_pay".localize("銀聯卡")
            
        case .payDollar:
            return "order_label_confirm_mobile_octopus".localize("Octopus")
        
        case .tossPay:
            return "Toss Pay"
        
        case .tossCard:
            return "order_label_confirm_kcp_credit_card".localize("信用卡")
            
        case .atome:
            return "Atome"
            
        case .zero:
            return ""
        }
    }
    
    func getDisplayImages(acceptedCardTypes: [CreditCardType] = []) -> [UIImage?] {
        switch self {
        case .stripeCard, .fubonCard, .tapPayCard, .adyenCard, .adyenKCPCard, .tapPayTravelCard:
            return acceptedCardTypes.map { $0.image }
        
        case .stripeApplePay, .tapPayApplePay:
            return [UIImage(named: "ic-payment-applepay")]

        case .linepay:
            return [UIImage(named: "linepay-point")]

        case .stripeAlipay, .alipayCN:
            return [UIImage(named: "icPaymentAlipayColor")]

        case .alipayHK:
            return [UIImage(named: "icPaymentAlipayHk")]
        
        case .adyenMomoWallet:
            return [UIImage(named: "icMomowalletColor")]
        
        case .adyenGrabPay:
            return [UIImage(named: "icMomowalletColor")]
            
        case .jkos:
            return [UIImage(named: "icPaymentJkOpay")]
            
        case .onePay:
            return [UIImage(named: "ic-payment-credit-card-color")]
            
        case .payDollar:
            return [UIImage(named: "icBookingIcBookingOctopus")]
            
        case .adyenUnionPay:
            return [UIImage(named: "icPaymentUnion")]
            
        case .tossPay:
            return [UIImage(named: "icPaymentToss")]
        
        case .tossCard:
            return [UIImage(named: "ic-payment-credit-card-color")]
            
        case .atome:
            return [UIImage(named: "icAtome")]
            
        case .zero:
            return []
        }
    }
    
    private func getCreditCardName(channels: [PaymentChannel]) -> String {

        // https://kkday.slack.com/archives/GRS4E3BT4/p1614914397013500
        let isContainsKCP: Bool = channels.contains(where: { (channel: PaymentChannel) -> Bool in
            return channel.type == PaymentType.adyenKCPCard
        })

        if isContainsKCP {
            let isKCP: Bool = self == PaymentType.adyenKCPCard
            
            // 신용카드  => (信用卡) 使用 KCP 付款頻道
            let kcpString: String = "신용카드"
            
            // 해외결제  => (海外支付) 使用 SG Stripe KRW 信用卡一般 & 3D 付款頻道（SG_STRIPE_CREDIT_CARD_KRW & SG_STRIPE_CREDIT_CARD_3D_KRW）。這兩個頻道的顯示文字只有在 ko 語系才修改，其他語系則維持原本信用卡文字。
            let stripeString: String = "해외결제"

            return isKCP ? kcpString : stripeString
        } else {
            return "order_label_confirm_credit_card".localize("信用卡")
        }
    }
}
