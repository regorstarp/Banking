//
//  CurrencyConverter.swift
//  Banking
//
//  Created by Roger Prats on 16/04/2019.
//  Copyright © 2019 Roger Prats. All rights reserved.
//

import Foundation

class CurrencyConverter {
    
    var currency: String = Currency.euro
    var rates: [Rate]
    var ratesNodes = [Node]()
    let dijkstraAlgorithm = DijkstraAlgorithm()
    
    init(currency: String = Currency.euro, rates: [Rate]) {
        self.currency = currency
        self.rates = rates
        self.ratesNodes = generateGraph()
    }
    
    func convert(transaction: Transaction) -> Double? {
        
        guard ratesNodes.count != 0, var amount = Double(transaction.amount) else {
            return nil
        }
        
        //no need to convert
        guard transaction.currency != currency else {
            return amount
        }
        
        guard let sourceNode = ratesNodes.first(where: { $0.name == transaction.currency }), let destinationNode = ratesNodes.first(where: { $0.name == currency }) else {
            return nil
        }
        
        //reset flag for all nodes
        for node in ratesNodes {
            node.visited = false
        }
        
        guard let shortestPath = dijkstraAlgorithm.shortestPath(source: sourceNode, destination: destinationNode) else {
            print("Failed finding path from \(sourceNode.name) to \(destinationNode.name)")
            return nil
        }
        
        let pathArray: [Node] = shortestPath.array.reversed()
        
        let succession: [String] = pathArray.map({$0.name })
//        print("🏁 Quickest path: \(succession)")
        
        for (index, node) in pathArray.enumerated() {
            for connection in node.connections {
                if index != pathArray.count - 1, connection.to.name == succession[index + 1] {
//                    print("\(node.name) --> \(connection.to.name) : \(connection.weight)")
                    amount *= connection.weight
                    break
                }
            }
        }
        return amount
    }
    
    private func generateGraph() -> [Node] {
        var nodes = [Node]()
        for rate in rates {

            guard let rateValue = Double(rate.rate) else {
                print("Unable to create double from string")
                continue
            }
            var toNode: Node
            if let index = nodes.firstIndex(where: { (node) -> Bool in
                return node.name == rate.to
            }) {
                toNode = nodes[index]
            } else {
                toNode = Node(name: rate.to)
                nodes.append(toNode)
            }
            
            var fromNode: Node
            if let index = nodes.firstIndex(where: { (node) -> Bool in
                return node.name == rate.from
            }) {
                fromNode = nodes[index]
            } else {
                fromNode = Node(name: rate.from)
                nodes.append(fromNode)
            }
            
            let connection = Connection(to: toNode, weight: rateValue)
            fromNode.connections.append(connection)
        }
        return nodes
    }
}
