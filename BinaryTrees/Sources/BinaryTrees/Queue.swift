//
//  Queue.swift
//  
//
//  Created by Andrew Lauer Barinov on 1/28/22.
//

import Foundation

class Queue<A> {
    var store: [A] = []

    func enqueue(_ element: A) {
        self.store.append(element)
    }

    func dequeue() -> A? {
        if let _ = self.store.first {
            return self.store.removeFirst()
        } else {
            return nil
        }
    }

    var isEmpty: Bool {
        return self.store.isEmpty
    }
}

extension Queue where A : CustomStringConvertible {
    var description: String {
        var result = ""

        for i in 0..<self.store.count {
            result = result + self.store[i].description
        }

        return result
    }
}
