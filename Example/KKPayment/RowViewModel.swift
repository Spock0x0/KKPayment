//
//  RowViewModel.swift
//  KKPayment_Example
//
//  Created by Spock on 2022/9/19.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation

protocol RowViewModel {}

protocol ViewModelPressable {
    var cellPressed: ( ()-> Void )? { get set }
}

protocol CellConfigurable {
    func setup(viewModel: RowViewModel)
}
