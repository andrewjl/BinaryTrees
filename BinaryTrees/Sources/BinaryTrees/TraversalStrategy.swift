//
//  TraversalStrategy.swift
//  
//
//  Created by Andrew Lauer Barinov on 1/28/22.
//

import Foundation

public enum TraversalStrategy {
    case preorderDepthFirst
    case inorderDepthFirst
    case postorderDepthFirst
    case breadthFirst
}

extension TraversalStrategy: CustomStringConvertible {
    public var description: String {
        switch self {
        case .preorderDepthFirst:
            return "Preorder Depth First"
        case .inorderDepthFirst:
            return "Inorder Depth First"
        case .postorderDepthFirst:
            return "Postorder Depth First"
        case .breadthFirst:
            return "Breadth First"
        }
    }
}
