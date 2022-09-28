//
//  JKOViewController.swift
//  KKPayment_Example
//
//  Created by Spock on 2022/9/19.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
import KKPayment
import SnapKit

class JKOViewController: UIViewController {
    
    let paymentService = PaymentService()
    var availableChannels: [PaymentChannel] = []
    
    lazy var makePaymentBtn: UIButton = {
       let btn = UIButton()
        btn.setTitle("Checkout", for: .normal)
        btn.setTitleColor(.blue, for: .normal)
        btn.addTarget(self, action: #selector(handleCheckOut), for: .touchUpInside)
        return btn
    }()
    
    lazy var getChannelsBtn: UIButton = {
       let btn = UIButton()
        btn.setTitle("Get Channels", for: .normal)
        btn.setTitleColor(.blue, for: .normal)
        btn.addTarget(self, action: #selector(handleGetChannels), for: .touchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(makePaymentBtn)
        view.addSubview(getChannelsBtn)
        
        getChannelsBtn.snp.makeConstraints {
            $0.width.equalTo(200)
            $0.centerX.centerY.equalToSuperview()
        }
        
        makePaymentBtn.snp.makeConstraints {
            $0.size.equalTo(getChannelsBtn)
            $0.centerX.equalTo(getChannelsBtn)
            $0.top.equalTo(getChannelsBtn).offset(50)
        }

    }
    
    private func getPaymentStrategy() -> PaymentChannelStrategy? {
        
        // Mock payment param
        let param: PaymentStrategyInitializeParameters = PaymentStrategyInitializeParameters(
            id: "mockId",
            pmchCode: "JKO_TWD",
            receiveMethod: "ONLINE_JKO",
            is3D: false,
            isHRP: "N",
            currency: .twd,
            additionalSettingDictionary: [:],
            acceptedCardTypes: [],
            paymentFlowEventDelegate: nil)
        
        return paymentService.createPaymentChannelStrategy(parameters: param)
    }
    
    @objc private func handleCheckOut() {
        availableChannels[0].strategy?.makePayment()
    }
    
    @objc private func handleGetChannels() {
        let availableChannels = paymentService.getPaymentChannels()
        print("availableChannels: ", availableChannels)
        self.availableChannels = availableChannels
    }
}
