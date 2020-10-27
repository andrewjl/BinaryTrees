import Foundation

let spacer = " "

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

class Node<A> {
    let head: A
    
    var leftChild: Node?
    var rightChild: Node?
    
    init(_ head: A, leftChild: Node? = nil, rightChild: Node? = nil) {
        self.head = head
        self.leftChild = leftChild
        self.rightChild = rightChild
    }
    
    init(_ head: A) {
        self.head = head
    }
    
    init(_ head: A, leftChildHead: A? = nil, rightChildHead: A? = nil) {
        self.head = head
        
        if let unwrappedLeftChildHead = leftChildHead {
            self.leftChild = Node(unwrappedLeftChildHead)
        }
        
        if let unwrappedRightChildHead = rightChildHead {
            self.rightChild = Node(unwrappedRightChildHead)
        }
    }
    
    func traverseDepthFirst(strategy: DepthTraversalStrategy,
                            closure: (A) -> ()) {
        
        switch strategy {
            case .preorder:
                switch (self.leftChild, self.rightChild) {
                    case (nil, nil):
                        closure(self.head)
                    case (let leftChild?, nil):
                        closure(self.head)
                        leftChild.traverseDepthFirst(strategy: strategy,
                                                     closure: closure)
                    case (nil, let rightChild?):
                        closure(self.head)
                        rightChild.traverseDepthFirst(strategy: strategy,
                                                      closure: closure)
                    case(let leftChild?, let rightChild?):
                        closure(self.head)
                        leftChild.traverseDepthFirst(strategy: strategy,
                                                     closure: closure)
                        rightChild.traverseDepthFirst(strategy: strategy,
                                                      closure: closure)
                }
            case .inorder:
                switch (self.leftChild, self.rightChild) {
                    case (nil, nil):
                        closure(self.head)
                    case (let leftChild?, nil):
                        leftChild.traverseDepthFirst(strategy: strategy,
                                                     closure: closure)
                        closure(self.head)
                    case (nil, let rightChild?):
                        closure(self.head)
                        rightChild.traverseDepthFirst(strategy: strategy,
                                                      closure: closure)
                    case(let leftChild?, let rightChild?):
                        leftChild.traverseDepthFirst(strategy: strategy,
                                                     closure: closure)
                        closure(self.head)
                        rightChild.traverseDepthFirst(strategy: strategy,
                                                      closure: closure)
                }
            case .postorder:
                switch (self.leftChild, self.rightChild) {
                    case (nil, nil):
                        closure(self.head)
                    case (let leftChild?, nil):
                        leftChild.traverseDepthFirst(strategy: strategy,
                                                     closure: closure)
                        closure(self.head)
                    case (nil, let rightChild?):
                        rightChild.traverseDepthFirst(strategy: strategy,
                                                      closure: closure)
                        closure(self.head)
                        
                    case(let leftChild?, let rightChild?):
                        leftChild.traverseDepthFirst(strategy: strategy,
                                                     closure: closure)
                        rightChild.traverseDepthFirst(strategy: strategy,
                                                      closure: closure)
                        closure(self.head)
                }
        }
    }
}

extension Node where A : CustomStringConvertible {
    var printedChildren: String {
        var result = ""
    
        if let unwrappedLeftChild = self.leftChild {
            result = result + spacer + unwrappedLeftChild.head.description
        }
        
        if let unwrappedRightChild = self.rightChild {
            result = result + spacer + unwrappedRightChild.head.description
        }
        
        if let leftPrintedChildren = self.leftChild?.printedChildren {
            result = result + leftPrintedChildren
        }
        
        if let rightPrintedChildren = self.rightChild?.printedChildren {
            result = result + rightPrintedChildren
        }
        
        return result
    }
    
    var description: String {
        return self.head.description
    }
}

func printBreadthFirst(node: Node<String>) -> String {
    var result = ""
    
    let queue = Queue<Node<String>>()
    
    queue.enqueue(node)
    
    while queue.isEmpty == false  {
        if let dequeuedNode = queue.dequeue() {
            result = result + spacer + dequeuedNode.head
        
            if let leftChild = dequeuedNode.leftChild {
                queue.enqueue(leftChild)
            }
        
            if let rightChild = dequeuedNode.rightChild {
                queue.enqueue(rightChild)
            }
        }
    }

    return String(result.dropFirst())
}

enum DepthTraversalStrategy {
    case preorder
    case inorder
    case postorder
}

func printDepthFirst(node: Node<String>, strategy:DepthTraversalStrategy = .preorder) -> String {
    var result = ""

    if strategy == .preorder {
        switch (node.leftChild, node.rightChild) {
            case (nil, nil):
                result = node.head
            case (let leftChild?, nil):
                result = node.head + spacer + printDepthFirst(node: leftChild, strategy: strategy)
            case (nil, let rightChild?):
                result = node.head + spacer + printDepthFirst(node: rightChild, strategy: strategy)
            case(let leftChild?, let rightChild?):
                result = node.head + spacer + printDepthFirst(node: leftChild, strategy: strategy) + spacer + printDepthFirst(node: rightChild, strategy: strategy)
        }
    } else if strategy == .inorder {
        switch (node.leftChild, node.rightChild) {
            case (nil, nil):
                result = node.head
            case (let leftChild?, nil):
                result = printDepthFirst(node: leftChild, strategy: strategy) + spacer + node.head
            case (nil, let rightChild?):
                result = node.head + spacer + printDepthFirst(node: rightChild, strategy: strategy)
            case(let leftChild?, let rightChild?):
                result = printDepthFirst(node: leftChild, strategy: strategy) + spacer + node.head + spacer + printDepthFirst(node: rightChild, strategy: strategy)
        }
    } else if strategy == .postorder {
        switch (node.leftChild, node.rightChild) {
            case (nil, nil):
                result = node.head
            case (let leftChild?, nil):
                result = printDepthFirst(node: leftChild, strategy: strategy) + spacer + node.head
            case (nil, let rightChild?):
                result = printDepthFirst(node: rightChild, strategy: strategy) + spacer + node.head
            case(let leftChild?, let rightChild?):
                result = printDepthFirst(node: leftChild, strategy: strategy) + spacer + printDepthFirst(node: rightChild, strategy: strategy) + spacer + node.head
        }
    }
    
    return result
}

/*
                    a
           b                        c
     d            e            f        g
  h     i      j     k      l     m  n     o
p   q r   s  t   u v   w  x   y  z

*/

let cNode = Node("c",
                leftChild: Node("f",
                                leftChild: Node("l", leftChildHead: "x", rightChildHead: "y"),
                                rightChild: Node("m", leftChildHead: "z")),
                rightChild: Node("g", leftChildHead: "n", rightChildHead: "o"))

let sampleNode = Node("a",
                 leftChild: Node("b",
                            leftChild: Node("d",
                                       leftChild: Node("h", leftChildHead: "p", rightChildHead: "q"),
                                       rightChild: Node("i", leftChildHead: "r", rightChildHead: "s")),
                            rightChild: Node("e",
                                        leftChild: Node("j", leftChildHead: "t", rightChildHead: "u"),
                                        rightChild: Node("k", leftChildHead: "v", rightChildHead: "w"))),
                rightChild: cNode)
                
let fNode = Node("F",
            leftChild: Node("D",
                            leftChild: Node("B",
                                            leftChildHead: "A",
                                            rightChildHead: "C"),
                            rightChild: Node("E")),
            rightChild: Node("J",
                            leftChild: Node("G", leftChild: Node("I", leftChildHead: "H")),
                            rightChild: Node("K")))
                
let printedNode = printBreadthFirst(node: sampleNode)

print("Print Breadth First: \(printedNode)")

let inorderDepthFirstPrintedNode = printDepthFirst(node: sampleNode, strategy: .inorder)
print("Inorder: \(inorderDepthFirstPrintedNode)")

let postorderDepthFirstPrintedNode = printDepthFirst(node: sampleNode, strategy: .postorder)
print("Postorder: \(postorderDepthFirstPrintedNode)")

print("Inorder (M): \(printDepthFirst(node: fNode, strategy: .inorder))")

var inorderTravesalResult = ""
fNode.traverseDepthFirst(strategy: .inorder,
                              closure: { inorderTravesalResult.append(spacer); inorderTravesalResult.append($0) })
print("Inorder (TR) \(inorderTravesalResult)")

print("Postorder (M): \(printDepthFirst(node: fNode, strategy: .postorder))")

var postOrderTraversalResult = ""
fNode.traverseDepthFirst(strategy: .postorder,
                         closure: { postOrderTraversalResult.append(spacer); postOrderTraversalResult.append($0)})

print("Postorder (TR) \(postOrderTraversalResult)")

let preorderDepthFirstPrintedNode = printDepthFirst(node: sampleNode, strategy: .preorder)
print("Preorder (M): \(preorderDepthFirstPrintedNode)")

var preOrderTraversalResult = ""

sampleNode.traverseDepthFirst(strategy: .preorder,
                              closure: { preOrderTraversalResult.append(spacer); preOrderTraversalResult.append($0) })

print("Preorder (TR) \(preOrderTraversalResult)")

