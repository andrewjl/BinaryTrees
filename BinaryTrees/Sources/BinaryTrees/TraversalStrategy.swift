//
//  TraversalStrategy.swift
//  
//
//  Created by Andrew Lauer Barinov on 1/28/22.
//

import Foundation

enum TraversalStrategy {
    case preorderDepthFirst
    case inorderDepthFirst
    case postorderDepthFirst
    case breadthFirst
}

extension TraversalStrategy: CustomStringConvertible {
    var description: String {
        switch self {
        case .preorderDepthFirst:
            return "Preorder DFS"
        case .inorderDepthFirst:
            return "Inorder DFS"
        case .postorderDepthFirst:
            return "Postorder DFS"
        case .breadthFirst:
            return "BFS"
        }
    }
}
