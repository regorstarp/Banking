//
//  Requester.swift
//  Banking
//
//  Created by Roger Prats on 15/04/2019.
//  Copyright © 2019 Roger Prats. All rights reserved.
//

import Foundation

class Requester {
    
    func fetchRates(completion: @escaping (Result<[Rate], Error>) -> ()) {
        let request = RatesRequest()
        
        do {
            let url = try request.makeRequest()
            URLSession.shared.dataTask(with: url) { (data, urlResponse, error) in
                
                guard let data = data else { return completion(.failure(error!)) }
                
                do {
                    let parsedResponse = try request.parseResponse(data: data)
                    completion(.success(parsedResponse))
                    
                } catch let jsonError {
                    completion(.failure(jsonError))
                }
            }.resume()
        } catch let urlError { completion(.failure(urlError)) }
    }
    
    func fetchTransactions(completion: @escaping (Result<[Transaction], Error>) -> () ) {
        let request = TransactionsRequest()
        
        do {
            let url = try request.makeRequest()
            URLSession.shared.dataTask(with: url) { (data, urlResponse, error) in
                
                guard let data = data else { return completion(.failure(error!)) }
                
                do {
                    let parsedResponse = try request.parseResponse(data: data)
                    completion(.success(parsedResponse))
                    
                } catch let jsonError {
                    completion(.failure(jsonError))
                }
            }.resume()
        } catch let urlError { completion(.failure(urlError)) }
    }
}
