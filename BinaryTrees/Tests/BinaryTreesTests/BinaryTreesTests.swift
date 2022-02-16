import XCTest
@testable import BinaryTrees

final class BinaryTreesTests: XCTestCase {
    func testNodePreorderIterator() throws {
        let node = Node(
            7,
            leftChild: Node(3),
            rightChild: Node(
                9,
                leftChildHead: 8,
                rightChildHead: 10
            )
        )

        XCTAssertEqual(
            preorderDepthFirstTraversal(node: node),
            [7, 3, 9, 8, 10]
        )

        XCTAssertEqual(
            Array(node.preOrderIterator),
            [7, 3, 9, 8, 10]
        )
    }
}
