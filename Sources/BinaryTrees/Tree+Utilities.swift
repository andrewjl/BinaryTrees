//
//  Tree+Utilities.swift
//  
//
//  Created by Andrew Lauer Barinov on 2/16/22.
//

import Foundation

extension Tree: Equatable where Element: Equatable {
    public static func == (lhs: Tree, rhs: Tree) -> Bool {
        return lhs.head == rhs.head &&
        lhs.leftChild == rhs.leftChild &&
        rhs.rightChild == rhs.rightChild
    }
}

extension Tree: CustomStringConvertible where Element: CustomStringConvertible {
    public var description: String {
        let left = leftChild?.description ?? "Empty"
        let right = rightChild?.description ?? "Empty"

        return "\n ******** \n Head: \(head.description) \n \n Left: \(left) \n \n Right: \(right)"
    }
}

extension Tree {
    public func traverse(
        strategy: TraversalStrategy,
        forEach: (Element) -> ()
    ) {
        traversed(
            node: self,
            strategy: strategy
        ).forEach { forEach($0) }
    }

    public var count: Int {
        var result = 0

        if let lc = self.leftChild {
            result += lc.count
        }

        if let rc = self.rightChild {
            result += rc.count
        }

        result += 1

        return result
    }

    public func map<ConvertedElement>(
        _ conversion: (Element) -> (ConvertedElement)
    ) -> Tree<ConvertedElement> {
        return Tree<ConvertedElement>(
            conversion(head),
            leftChild: leftChild?.map(conversion),
            rightChild: rightChild?.map(conversion)
        )
    }
}
