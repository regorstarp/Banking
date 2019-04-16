//
//  DijkstraAlgorithm.swift
//  Banking
//
//  Created by Roger Prats on 16/04/2019.
//  Copyright © 2019 Roger Prats. All rights reserved.
//

import Foundation

class DijkstraAlgorithm {
    func shortestPath(source: Node, destination: Node) -> Path? {
        var frontier: [Path] = []
        
        frontier.append(Path(to: source)) // the frontier is made by a path that starts nowhere and ends in the source
        
        while !frontier.isEmpty {
            let cheapestPathInFrontier = frontier.removeFirst() // getting the cheapest path available
            guard !cheapestPathInFrontier.node.visited else { continue } // making sure we haven't visited the node already
            
            if cheapestPathInFrontier.node === destination || cheapestPathInFrontier.node.name == destination.name {
                return cheapestPathInFrontier // found the cheapest path 😎
            }
            
            cheapestPathInFrontier.node.visited = true
            
            for connection in cheapestPathInFrontier.node.connections where !connection.to.visited { // adding new paths to our frontier
                frontier.append(Path(to: connection.to, via: connection, previousPath: cheapestPathInFrontier))
            }
        } // end while
        return nil // we didn't find a path 😣
    }
}
