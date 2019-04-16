//
//  RatesRequestTest.swift
//  BankingTests
//
//  Created by Roger Prats on 16/04/2019.
//  Copyright © 2019 Roger Prats. All rights reserved.
//

import XCTest
@testable import Banking

class RatesRequestTest: XCTestCase {
    
    let request = RatesRequest()

    func testParsingResponse() throws {
        let jsonData = "[{\"from\":\"EUR\",\"to\":\"CAD\",\"rate\":\"1.32\"},{\"from\":\"CAD\",\"to\":\"EUR\",\"rate\":\"0.76\"},{\"from\":\"EUR\",\"to\":\"USD\",\"rate\":\"0.75\"},{\"from\":\"USD\",\"to\":\"EUR\",\"rate\":\"1.33\"},{\"from\":\"CAD\",\"to\":\"AUD\",\"rate\":\"1.42\"},{\"from\":\"AUD\",\"to\":\"CAD\",\"rate\":\"0.7\"}]".data(using: .utf8)!
        let response = try request.parseResponse(data: jsonData)
        
        let rates: [Rate] = [
            Rate(from: Currency.euro, to: Currency.canadianDollar, rate: "1.32"),
            Rate(from: Currency.canadianDollar, to: Currency.euro, rate: "0.76"),
            Rate(from: Currency.euro, to: Currency.dollar, rate: "0.75"),
            Rate(from: Currency.dollar, to: Currency.euro, rate: "1.33"),
            Rate(from: Currency.canadianDollar, to: Currency.australianDollar, rate: "1.42"),
            Rate(from: Currency.australianDollar, to: Currency.canadianDollar, rate: "0.7")
        ]
        
        XCTAssertEqual(response, rates)
        
    }

}
