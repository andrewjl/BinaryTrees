# Binary Trees

A binary tree data structure and its related algorithms implemented in Swift. 

### Planned Additions

- [x] Array conversion free functions for all 3 depth first traversals
- [x] Array conversion free functions for breadth first traversal
- [x] Preorder depth first traversal iterator
- [ ] Inorder depth first traversal iterator 
- [ ] Postorder depth first traversal iterator
- [ ] Breadth first iterator
- [x] Conditional conformances for `CustomStringConvertible`, `Equatable`
- [x] Element counting and visitation utilities
- [x] `map` API
- [ ] `reduce` API
- [ ] A `struct` form that supports copy-on-write (COW)
- [ ] An `enum` form
- [ ] Further test coverage

## Usage Examples

### Data Structure

Create a leaf form of a binary tree as follows:

```swift
let leaf = Node(42)
```

A tree can contain any type of element as long as type stored in each parent 
and child pair matches: 

```swift
let treeFromIntegerLiteralElements = Node(21, leftChildHead: 10, rightChildHead: 42)

let treeFromStrings = Node("G", leftChildHead: "A", rightChildHead: "N")
```

Complex trees can be built inline or from the bottom up recursively

```swift
let rightConstiuentSubtree = Node(42, left: Node(30), right: Node(48))

let tree = Node(21, left: Node(10), right: rightConstiuentSubtree)
```

### Tree Traversal

A tree can be converted to an array by traversing it:

```swift
let tree = /** construct tree **/
let preorderTraversal = preorderDepthFirstTraversal(tree)
```   

Traversal free functions are available for breadth first as well as preorder, inorder, postorder depth first traversals. See `TraversalFreeFunctions.swift`

A preorder depth first traversal iterator can be computed:

```swift
let tree = /** construct tree **/
let preorderIterator = tree.preorderIterator
```

### Helpful Extras

A count of all the elements in the tree:

```swift
let tree = /** construct tree **/
let count = tree.count
```

Supply a closure and have the tree apply it to each element following a traversal
path:

```swift
let tree: Tree<Int> = /** construct tree **/
let task: (Int) -> Void = { element in
    print(element)
}
tree.traverse(strategy: .postorderDepthFirst, forEach: task)
```

Map the trees elements to another value:

```swift
let tree: Tree<Int> = /** construct tree **/
let stringifiedTree = tree.map { $0.description }
```
