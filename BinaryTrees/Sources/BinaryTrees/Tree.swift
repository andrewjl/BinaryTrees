//
//  Tree.swift
//  
//
//  Created by Andrew Lauer Barinov on 1/28/22.
//

import Foundation

public class Tree<Element> {
    public let head: Element

    public var leftChild: Tree?
    public var rightChild: Tree?

    public init(_ head: Element, leftChild: Tree? = nil, rightChild: Tree? = nil) {
        self.head = head
        self.leftChild = leftChild
        self.rightChild = rightChild
    }

    public init(_ head: Element) {
        self.head = head
    }

    public init(_ head: Element, leftChildHead: Element? = nil, rightChildHead: Element? = nil) {
        self.head = head

        if let unwrappedLeftChildHead = leftChildHead {
            self.leftChild = Tree(unwrappedLeftChildHead)
        }

        if let unwrappedRightChildHead = rightChildHead {
            self.rightChild = Tree(unwrappedRightChildHead)
        }
    }
}

