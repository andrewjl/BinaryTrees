import XCTest
@testable import BinaryTrees

final class BinaryTreesTests: XCTestCase {
    func testPreorderTraversal() throws {
        let tree = Tree(
            7,
            leftChild: Tree(3),
            rightChild: Tree(
                9,
                leftChildHead: 8,
                rightChildHead: 10
            )
        )

        XCTAssertEqual(
            preorderDepthFirstTraversal(node: tree),
            [7, 3, 9, 8, 10]
        )

        XCTAssertEqual(
            Array(tree.preorderIterator),
            [7, 3, 9, 8, 10]
        )
    }

    func testCount() throws {
        let tree = Tree(
            7,
            leftChild: Tree(3),
            rightChild: Tree(
                9,
                leftChildHead: 8,
                rightChildHead: 10
            )
        )

        XCTAssertEqual(
            tree.count,
            5
        )
    }

    func testMap() throws {
        let tree = Tree(
            7,
            leftChild: Tree(3),
            rightChild: Tree(
                9,
                leftChildHead: 8,
                rightChildHead: 10
            )
        )

        let descriptiveTree = Tree(
            7.description,
            leftChild: Tree(3.description),
            rightChild: Tree(
                9.description,
                leftChildHead: 8.description,
                rightChildHead: 10.description
            )
        )

        XCTAssertEqual(tree.map(\Int.description), descriptiveTree)

        print(descriptiveTree)
    }
}
