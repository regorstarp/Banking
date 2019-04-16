//
//  APIRequest.swift
//  Banking
//
//  Created by Roger Prats on 16/04/2019.
//  Copyright © 2019 Roger Prats. All rights reserved.
//

import Foundation

protocol APIRequest {
    associatedtype ResponseDataType
    
    func makeRequest() throws -> URLRequest
    func parseResponse(data: Data) throws -> ResponseDataType
}

struct RatesRequest: APIRequest {
    func makeRequest() throws -> URLRequest {
        let urlString = "https://quiet-stone-2094.herokuapp.com/rates.json"
        let url = URL(string: urlString)!
        return URLRequest(url: url)
    }
    
    func parseResponse(data: Data) throws -> [Rate] {
        return try JSONDecoder().decode([Rate].self, from: data)
    }
}

struct TransactionsRequest: APIRequest {
    func makeRequest() throws -> URLRequest {
        let urlString = "https://quiet-stone-2094.herokuapp.com/transactions.json"
        let url = URL(string: urlString)!
        return URLRequest(url: url)
    }
    
    func parseResponse(data: Data) throws -> [Transaction] {
        return try JSONDecoder().decode([Transaction].self, from: data)
    }
}
