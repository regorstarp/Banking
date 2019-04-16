//
//  Rates.swift
//  Banking
//
//  Created by Roger Prats on 15/04/2019.
//  Copyright © 2019 Roger Prats. All rights reserved.
//

import Foundation

struct Rate: Decodable, Equatable {
    let from: String
    let to: String
    let rate: String
}

struct Currency {
    static let euro = "EUR"
    static let dollar = "USD"
    static let canadianDollar = "CAD"
    static let australianDollar = "AUD"
    static let pound = "GBP"
}
