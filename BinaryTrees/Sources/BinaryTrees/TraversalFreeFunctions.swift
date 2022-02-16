//
//  StructTree.swift
//

import Foundation

let spacer = " "

func preorderDepthFirstTraversal<A>(node: Node<A>) -> [A] {
    var result:[A] = [node.head]

    if let lc = node.leftChild {
        result.append(contentsOf: preorderDepthFirstTraversal(node: lc))
    }

    if let rc = node.rightChild {
        result.append(contentsOf: preorderDepthFirstTraversal(node: rc))
    }

    return result
}


func inorderDepthFirstTraversal<A>(node: Node<A>) -> [A] {
    var result = [A]()

    if let lc = node.leftChild {
        result.append(contentsOf: inorderDepthFirstTraversal(node: lc))
    }

    result.append(node.head)

    if let rc = node.rightChild {
        result.append(contentsOf: inorderDepthFirstTraversal(node: rc))
    }

    return result
}

func postorderDepthFirstTraversal<A>(node: Node<A>) -> [A] {
    var result = [A]()

    if let lc = node.leftChild {
        result.append(contentsOf: postorderDepthFirstTraversal(node: lc))
    }

    if let rc = node.rightChild {
        result.append(contentsOf: postorderDepthFirstTraversal(node: rc))
    }

    result.append(node.head)

    return result
}

func breadthFirstTraversal<A>(node: Node<A>) -> [A] {
    var result = [A]()

    let queue = Queue<Node<A>>()
    queue.enqueue(node)

    while queue.isEmpty == false  {
        if let dequeuedNode = queue.dequeue() {
            result.append(dequeuedNode.head)

            if let lc = dequeuedNode.leftChild {
                queue.enqueue(lc)
            }

            if let rc = dequeuedNode.rightChild {
                queue.enqueue(rc)
            }
        }
    }

    return result
}

func traversed<A>(node: Node<A>,
                  strategy: TraversalStrategy) -> [A] {

    switch strategy {
    case .preorderDepthFirst:
        return preorderDepthFirstTraversal(node: node)
    case .inorderDepthFirst:
        return inorderDepthFirstTraversal(node: node)
    case .postorderDepthFirst:
        return postorderDepthFirstTraversal(node: node)
    case .breadthFirst:
        return breadthFirstTraversal(node: node)
    }

}
