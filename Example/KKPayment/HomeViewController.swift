//
//  HomeViewController.swift
//  KKPayment
//
//  Created by Spock on 08/30/2022.
//  Copyright (c) 2022 Spock. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(HomeCell.self, forCellReuseIdentifier: HomeCell.identifier)
        return tableView
    }()
    
    let dataServices = DataServices()
    var cellData = [RowViewModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.frame = view.bounds
        dataServices.fetchDemoData { material in
            self.buildViewModels(materials: material)
        }
    }

}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let rowViewModel = cellData[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeCell.identifier, for: indexPath)
        if let cell = cell as? CellConfigurable {
            cell.setup(viewModel: rowViewModel)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let rowViewModel = cellData[indexPath.row] as? ViewModelPressable {
            rowViewModel.cellPressed?()
        }
    }
    
}

extension HomeViewController {
    func buildViewModels(materials: [Material]) {
        for material in materials {
            let cellVM = HomeCellViewModel(title: material.title)
            cellVM.cellPressed = {
                self.present(material.viewController, animated: true, completion: nil)
            }
            self.cellData.append(cellVM)
        }
        self.tableView.reloadData()
    }
}

