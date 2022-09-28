//
//  DataServices.swift
//  KKPayment_Example
//
//  Created by Spock on 2022/9/19.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

class DataServices {
    enum PaymentType: Int, CaseIterable {
        case jko
        
        var title: String {
            switch self {
            case .jko:
                return "JKO"
            }
        }
        
        var vc: UIViewController {
            switch self {
            case .jko:
                return JKOViewController()
            }
        }
    }
    
    private lazy var demoMaterial: [Material] = {
        var materials = [Material]()
        for index in 0...PaymentType.allCases.count - 1 {
            if let type = PaymentType(rawValue: index) {
                let basic = DemoData(title: type.title, viewController: type.vc)
                materials.append(basic)
            }
        }
        return materials
    }()
    
    func fetchDemoData(complete: @escaping([Material]) -> Void) {
        complete(self.demoMaterial)
    }
}
