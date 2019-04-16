//
//  TransactionsRequestTest.swift
//  BankingTests
//
//  Created by Roger Prats on 16/04/2019.
//  Copyright © 2019 Roger Prats. All rights reserved.
//

import XCTest
@testable import Banking

class TransactionsRequestTest: XCTestCase {
    let request = TransactionsRequest()

    func testTransactionsRequest() throws {
        let jsonData = "[{\"sku\":\"R2522\",\"amount\":\"19.4\",\"currency\":\"USD\"},{\"sku\":\"R2522\",\"amount\":\"25.5\",\"currency\":\"CAD\"},{\"sku\":\"M1643\",\"amount\":\"22.0\",\"currency\":\"EUR\"},{\"sku\":\"M1643\",\"amount\":\"16.3\",\"currency\":\"USD\"},{\"sku\":\"L4918\",\"amount\":\"24.1\",\"currency\":\"EUR\"},{\"sku\":\"Y0207\",\"amount\":\"25.5\",\"currency\":\"USD\"}]".data(using: .utf8)!
        let response = try request.parseResponse(data: jsonData)
        
        let transactions: [Transaction] = [
            Transaction(sku: "R2522", amount: "19.4", currency: Currency.dollar),
            Transaction(sku: "R2522", amount: "25.5", currency: Currency.canadianDollar),
            Transaction(sku: "M1643", amount: "22.0", currency: Currency.euro),
            Transaction(sku: "M1643", amount: "16.3", currency: Currency.dollar),
            Transaction(sku: "L4918", amount: "24.1", currency: Currency.euro),
            Transaction(sku: "Y0207", amount: "25.5", currency: Currency.dollar),
        ]
        
        XCTAssertEqual(response, transactions)
    }

}
