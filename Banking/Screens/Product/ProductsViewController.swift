//
//  ViewController.swift
//  Banking
//
//  Created by Roger Prats on 15/04/2019.
//  Copyright © 2019 Roger Prats. All rights reserved.
//

import UIKit

class ProductsViewController: UITableViewController {
    
    var rates = [Rate]()
    
    var products = [String]()
    
    let dataSource = ProductsDataSource()
    
    let dispatchGroup = DispatchGroup()
    let requester = Requester()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Products"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: dataSource.cellIdentifier)
        tableView.dataSource = dataSource
        fetch()
    }
    
    private func fetch() {
        fetchRates()
        fetchTransactions()
        dispatchGroup.notify(queue: .main) { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    private func fetchRates() {
        dispatchGroup.enter()
        requester.fetchRates { (result) in
            switch result {
            case .success(let rates):
                self.rates = rates
                self.dispatchGroup.leave()
            case .failure(let err):
                print("Failed to fetch rates:", err)
            }
        }
    }
    
    private func fetchTransactions() {
        dispatchGroup.enter()
        requester.fetchTransactions { (result) in
            switch result {
            case .success(let transactions):
                self.dataSource.transactions = transactions
                self.dispatchGroup.leave()
            case .failure(let err):
                print("Failed to fetch transactions:", err)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let productTransactions = dataSource.transactions(for: indexPath.row)
        pushDetailViewController(with: productTransactions)
    }
    
    private func pushDetailViewController(with transactions: [Transaction]) {
        let detailVC = TransactionsViewController()
        detailVC.transactions = transactions
        detailVC.rates = rates
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

