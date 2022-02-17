# Binary Trees

### Data Structure

Create a leaf form of a binary tree as follows:

```
let leaf = Node(42)
```

A tree can contain any type of element as long as type stored in each parent 
and child pair matches: 

```
let treeFromIntegerLiteralElements = Node(21, leftChildHead: 10, rightChildHead: 42)

let treeFromStrings = Node("G", leftChildHead: "A", rightChildHead: "N")
```

Complex trees can be built inline or from the bottom up recursively

```
let rightConstiuentSubtree = Node(42, left: Node(30), right: Node(48))

let tree = Node(21, left: Node(10), right: rightConstiuentSubtree)
```

### Tree Traversal

A tree can be converted to an array by traversing it:

```
let tree = /** construct tree **/
let preorderTraversal = preorderDepthFirstTraversal(tree)
```   

Traversal free functions are available for breadth first and all preorder, inorder, postorder depth first traversals. See `TraversalFreeFunctions.swift`


A preorder depth first traversal iterator can be computed:

```
let tree = /** construct tree **/
let preorderIterator = tree.preorderIterator
```

### Helpful Extras

A count of all the elements in the tree:

```
let tree = /** construct tree **/
let count = tree.count
```

Supply a closure and have the tree apply it to each element following a traversal
path:

```
let tree: Tree<Int> = /** construct tree **/
let task: (Int) -> Void = { element in
    print(element)
}
tree.traverse(strategy: .postorderDepthFirst, forEach: task)
```

Map the trees elements to another value:
```
let tree: Tree<Int> = /** construct tree **/
let descriptiveTree = tree.map { $0.description }
```
 

### Planned Additions

- [ ] Inorder, postorder depth first traversal iterators
- [ ] Breadth first iterator
- [ ] A `print` extension when the Tree element is convertible to string
- [ ] Support for `reduce`
- [ ] A `struct` form that supports copy-on-write (COW)
- [ ] Further test coverage
