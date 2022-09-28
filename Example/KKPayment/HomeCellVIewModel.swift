//
//  VIewModel.swift
//  KKPayment_Example
//
//  Created by Spock on 2022/9/19.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation

class HomeCellViewModel: RowViewModel, ViewModelPressable {
    var cellPressed: (() -> Void)?
    let title: String
    
    init (title: String) {
        self.title = title
    }
}
