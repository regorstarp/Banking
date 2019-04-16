//
//  Graph.swift
//  Banking
//
//  Created by Roger Prats on 15/04/2019.
//  Copyright © 2019 Roger Prats. All rights reserved.
//

import Foundation

class Node: Equatable {
    
    let name: String
    var visited = false
    var connections: [Connection] = []
    
    init(name: String) {
        self.name = name
    }
    
    static func == (lhs: Node, rhs: Node) -> Bool {
        return lhs.name == rhs.name
    }
}

class Connection {
    public let to: Node
    public let weight: Double
    
    public init(to node: Node, weight: Double) {
        assert(weight >= 0, "weight has to be equal or greater than zero")
        self.to = node
        self.weight = weight
    }
}

class Path {
    public let node: Node
    public let previousPath: Path?
    
    init(to node: Node, via connection: Connection? = nil, previousPath path: Path? = nil) {
        
        self.node = node
        self.previousPath = path
    }
}

extension Path {
    var array: [Node] {
        var array: [Node] = [self.node]
        
        var iterativePath = self
        while let path = iterativePath.previousPath {
            array.append(path.node)
            
            iterativePath = path
        }
        
        return array
    }
}

