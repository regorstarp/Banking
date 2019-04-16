//
//  DetailViewController.swift
//  Banking
//
//  Created by Roger Prats on 15/04/2019.
//  Copyright © 2019 Roger Prats. All rights reserved.
//

import UIKit

class TransactionsViewController: UITableViewController {
    
    var transactions = [Transaction]()
    var rates = [Rate]() {
        didSet {
            currencyConverter = CurrencyConverter(currency: Currency.euro, rates: rates)
        }
    }
    var currencyConverter: CurrencyConverter?
    
    private let cellIdentifier = "transactionCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        calculateTotalAmount()
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        let transaction = transactions[indexPath.row]
        cell.textLabel?.text = "\(transaction.amount) \(transaction.currency)"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactions.count
    }
    
    private func calculateTotalAmount() {
        
        guard rates.count != 0 else {
            print("No Rates!!")
            return
        }
        
        guard let currencyConverter = currencyConverter else {
            return
        }
        var total = 0.0
        for transaction in transactions {
            if let convertedAmount = currencyConverter.convert(transaction: transaction) {
                total += convertedAmount
            } else {
                print("Unable to convert")
            }
        }
        let totalString = String(format: "%.2f", total)
        title = totalString + " " + currencyConverter.currency
    }
}
