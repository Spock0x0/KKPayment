//
//  Material.swift
//  KKPayment_Example
//
//  Created by Spock on 2022/9/19.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit

protocol Material {
    var title: String { get set }
    var viewController: UIViewController { get set }
}

struct DemoData: Material {
    var title: String
    var viewController: UIViewController
}
