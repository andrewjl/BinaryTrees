//
//  Tree+Iterator.swift
//  
//
//  Created by Andrew Lauer Barinov on 2/16/22.
//

import Foundation

extension Tree {
    var preorderIterator: AnyIterator<Element> {
        let leftIterator = leftChild?.preorderIterator

        let rightIterator = rightChild?.preorderIterator

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
