//
//  Node.swift
//  
//
//  Created by Andrew Lauer Barinov on 1/28/22.
//

import Foundation

class Node<Element> {
    let head: Element

    var leftChild: Node?
    var rightChild: Node?

    init(_ head: Element, leftChild: Node? = nil, rightChild: Node? = nil) {
        self.head = head
        self.leftChild = leftChild
        self.rightChild = rightChild
    }

    init(_ head: Element) {
        self.head = head
    }

    init(_ head: Element, leftChildHead: Element? = nil, rightChildHead: Element? = nil) {
        self.head = head

        if let unwrappedLeftChildHead = leftChildHead {
            self.leftChild = Node(unwrappedLeftChildHead)
        }

        if let unwrappedRightChildHead = rightChildHead {
            self.rightChild = Node(unwrappedRightChildHead)
        }
    }

    func traverse(strategy: TraversalStrategy,
                  closure: (Element) -> ()) {
        traversed(node: self, strategy: strategy).forEach { closure($0) }
    }

    var count: Int {
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
}

extension Node {
    var preOrderIterator: AnyIterator<Element> {
        let leftIterator = leftChild?.preOrderIterator

        let rightIterator = rightChild?.preOrderIterator

        var headElement: Element? = self.head

        return AnyIterator {
            if let h = headElement {
                defer { headElement = nil }
                return h
            }

            if let nextLeft = leftIterator?.next() {
                return nextLeft
            }

            if let nextRight = rightIterator?.next() {
                return nextRight
            }

            return nil
        }
    }
}
