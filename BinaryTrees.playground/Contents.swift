import Foundation

let spacer = " "

enum TraversalStrategy {
    case preorderDepthFirst
    case inorderDepthFirst
    case postorderDepthFirst
    case breadthFirst
}

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
    var result = [A]()
    
    switch strategy {
        case .preorderDepthFirst:
            result = preorderDepthFirstTraversal(node: node)
        case .inorderDepthFirst:
            result = inorderDepthFirstTraversal(node: node)
        case .postorderDepthFirst:
            result = postorderDepthFirstTraversal(node: node)
        case .breadthFirst:
            result = breadthFirstTraversal(node: node)
    }
    
    return result
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
    
    func traverse(strategy: TraversalStrategy,
                  closure: (A) -> ()) {
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

struct TreeIterator<A> {
    let root: Node<A>
    let traversalStrategy: TraversalStrategy
    var count: Int
    var storage: [A]

    init(binaryTree: Node<A>,
         traversalStrategy: TraversalStrategy) {
        self.root = binaryTree
        self.traversalStrategy = traversalStrategy
        self.count = binaryTree.count
        self.storage = traversed(node: binaryTree, strategy: traversalStrategy).reversed()
    }

    mutating func next() -> A? {
        defer {
            self.count = self.count - 1
        }
        
        if count == 0 {
            return nil
        } else {
            return self.storage[self.count-1]
        }
    }
}

// Simplified accumulation function that wraps Array reduce.
// No type conversion support yet
// TBD: Error handling, folding into iterator that can handle more dynamism
func treeReduce<A>(node: Node<A>,
                   strategy: TraversalStrategy = .preorderDepthFirst,
                   initialResult: A,
                   updateAccumulatingResult: (A, A) -> (A)) -> A {
    return traversed(node: node,
                     strategy: strategy).reduce(initialResult, updateAccumulatingResult)
}

let simpleNode = Node(4,
                      leftChildHead: 3,
                      rightChildHead: 8)

let sum = treeReduce(node: simpleNode,
                     initialResult: 0) { $0 + $1 }

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
                            leftChild: Node("I", leftChild: Node("H", leftChildHead: "G")),
                            rightChild: Node("K")))







