//
//  Transaction.swift
//  Banking
//
//  Created by Roger Prats on 15/04/2019.
//  Copyright © 2019 Roger Prats. All rights reserved.
//

import Foundation

struct Transaction: Decodable, Equatable {
    let sku: String
    let amount: String
    let currency: String
}
