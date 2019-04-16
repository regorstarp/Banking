//
//  CurrencyConverterTest.swift
//  BankingTests
//
//  Created by Roger Prats on 16/04/2019.
//  Copyright © 2019 Roger Prats. All rights reserved.
//

import XCTest
@testable import Banking

class CurrencyConverterTest: XCTestCase {
    
    let rates: [Rate] = [
        Rate(from: Currency.euro, to: Currency.canadianDollar, rate: "1.32"),
        Rate(from: Currency.canadianDollar, to: Currency.euro, rate: "0.76"),
        Rate(from: Currency.euro, to: Currency.dollar, rate: "0.75"),
        Rate(from: Currency.dollar, to: Currency.euro, rate: "1.33"),
        Rate(from: Currency.canadianDollar, to: Currency.australianDollar, rate: "1.42"),
        Rate(from: Currency.australianDollar, to: Currency.canadianDollar, rate: "0.7"),
        Rate(from: Currency.pound, to: Currency.canadianDollar, rate: "0.9"),
    ]
    
    let transactions: [Transaction] = [
        Transaction(sku: "R2522", amount: "19.4", currency: Currency.dollar),
        Transaction(sku: "R2522", amount: "25.5", currency: Currency.canadianDollar),
        Transaction(sku: "M1643", amount: "22.0", currency: Currency.euro),
        Transaction(sku: "M1643", amount: "16.3", currency: Currency.dollar),
        Transaction(sku: "L4918", amount: "24.1", currency: Currency.euro),
        Transaction(sku: "Y0207", amount: "25.5", currency: Currency.dollar),
    ]

    //no need to convert currency
    func testCurrencyConvertSimple() {
        let transaction = transactions[0]
        let currencyConverter = CurrencyConverter(currency: Currency.dollar, rates: rates)
        
        if var convertedAmount = currencyConverter.convert(transaction: transaction) {
            convertedAmount = Double(round(100*convertedAmount)/100)
            XCTAssert(convertedAmount == 19.4)
        } else {
            XCTFail()
        }
    }
    
    //currency conversion already defined in rates
    func testCurrencyConvertDefined() {
        let transaction = transactions[0]
        let currencyConverter = CurrencyConverter(currency: Currency.euro, rates: rates)
        
        if var convertedAmount = currencyConverter.convert(transaction: transaction) {
            convertedAmount = Double(round(100*convertedAmount)/100)
            XCTAssert(convertedAmount == 25.80)
        } else {
            XCTFail()
        }
    }
    
    //currency conversion not defined in rates but is simple: USD -> EUR -> CAD
    func testCurrencyConvertDeduceSimple() {
        let transaction = transactions[0]
        let currencyConverter = CurrencyConverter(currency: Currency.canadianDollar, rates: rates)
        
        if var convertedAmount = currencyConverter.convert(transaction: transaction) {
            convertedAmount = Double(round(100*convertedAmount)/100)
            XCTAssert(convertedAmount == 34.06)
        } else {
            XCTFail()
        }
    }
    
    //currency conversion not defined in rates but is complex: USD -> EUR -> CAD -> AUD
    func testCurrencyConvertDeduceComplex() {
        let transaction = transactions[0]
        let currencyConverter = CurrencyConverter(currency: Currency.australianDollar, rates: rates)

        if var convertedAmount = currencyConverter.convert(transaction: transaction) {
            convertedAmount = Double(round(100*convertedAmount)/100)
            XCTAssert(convertedAmount == 48.36)
        } else {
            XCTFail()
        }
    }

    //currency not possible to deduce
    func testCurrencyConvertNotPossible() {
        let transaction = transactions[0]
        let currencyConverter = CurrencyConverter(currency: Currency.pound, rates: rates)

        XCTAssert(currencyConverter.convert(transaction: transaction) == nil)
    }
}
