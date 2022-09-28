//
//  HomeCell.swift
//  KKPayment_Example
//
//  Created by Spock on 2022/9/19.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

class HomeCell: UITableViewCell, CellConfigurable {
    static let identifier = "homeCell"
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.selectionStyle = .none
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
    }
    
    func setup(viewModel: RowViewModel) {
        guard let viewModel = viewModel as? HomeCellViewModel else { return }
        self.textLabel?.text = viewModel.title
    }
}
