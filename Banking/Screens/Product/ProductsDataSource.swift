//
//  TransactionsDataSource.swift
//  Banking
//
//  Created by Roger Prats on 15/04/2019.
//  Copyright © 2019 Roger Prats. All rights reserved.
//

import UIKit

class ProductsDataSource: NSObject, UITableViewDataSource {

    var transactions = [Transaction]() {
        didSet {
            transactions = transactions.sorted { $0.sku < $1.sku }
            setUniqueProductTransactions()
        }
    }
    var products = [String]()
    
    var cellIdentifier = "transactionCell"
    
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.textLabel?.text = products[indexPath.row]
        return cell
    }
    
    private func setUniqueProductTransactions(){
        products = [String]()
        for transaction in transactions {
            if !products.contains(where: { (productName) -> Bool in
                return productName == transaction.sku
            }) {
                products.append(transaction.sku)
            }
        }
    }
    
    func transactions(for productRow: Int) -> [Transaction] {
        let productName = products[productRow]
        return transactions.filter({ (transaction) -> Bool in
            return transaction.sku == productName
        })
    }
}
