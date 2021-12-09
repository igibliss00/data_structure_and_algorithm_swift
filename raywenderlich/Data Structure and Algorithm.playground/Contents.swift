import Foundation
import PlaygroundSupport
import XCTest

final class StackTests: XCTestCase {
    var stack = Stack<Int>()
    
    override func setUp() {
        stack.push(1)
        stack.push(2)
        stack.push(3)
        stack.push(4)
    }
    
    func test_push() {
        XCTAssertEqual(stack.description, "1 2 3 4", "Should evaluate to 1, 2, 3, 4")
    }
    
    func test_pop() {
        XCTAssertEqual(stack.pop(), 4, "Should evaluate to 4")
    }
    
    func test_peek() {
        XCTAssertEqual(stack.peek(), 4)
    }
    
    func test_isEmpty() {
        XCTAssertFalse(stack.isEmpty)
    }
    
    func test_initWithArray() {
        let array = [1, 2, 3, 4]
        XCTAssertEqual(stack, Stack(array))
    }
    
    func test_arrayLiteral() {
        let stack: Stack = ["blueberry", "plain", "potato"]
        XCTAssertEqual(stack, ["blueberry", "plain", "potato"])
    }
}

final class BinaryTreeTestCase: XCTestCase {
    var tree: BinaryNode<Int> = {
        let zero = BinaryNode(0)
        let one = BinaryNode(1)
        let five = BinaryNode(5)
        let seven = BinaryNode(7)
        let eight = BinaryNode(8)
        let nine = BinaryNode(9)
        
        seven.leftChild = one
        one.leftChild = zero
        one.rightChild = five
        seven.rightChild = nine
        nine.leftChild = eight
        return seven
    }()
    
    func test_visualizeBinaryTree() {
        print(tree.description)
    }
    
    func test_traverseInOrder() {
        var testArray: [Int] = []
        tree.traverseInOrder { testArray.append($0) }
        XCTAssertEqual(testArray, [0, 1, 5, 7, 8, 9])
    }
    
    func test_tarversePreOrder() {
        var testArr: [Int] = []
        tree.traversePreOrder { testArr.append($0) }
        XCTAssertEqual(testArr, [7, 1, 0, 5, 9, 8])
    }
    
    func trest_traversePostOrder() {
        var testArr: [Int] = []
        tree.traversePostOrder { testArr.append($0) }
        XCTAssertEqual(testArr, [0, 5, 1, 8, 9, 7])
    }
}

final class BinarySearchTestCase: XCTestCase {
    func test_binarySearch() {
        let array = [1, 5, 18, 32, 33, 33, 47, 502]
        XCTAssertEqual(array.binarySearch(for: 5), 1)
    }
}

// Call Tests
//TestRunner().runTests(testClass: StackTests.self)
//TestRunner().runTests(testClass: BinaryTreeTestCase.self)
TestRunner().runTests(testClass: BinarySearchTestCase.self)

class PlaygroundTestObserver: NSObject, XCTestObservation {
    @objc func testCase(_ testCase: XCTestCase, didFailWithDescription description: String, inFile filePath: String?, atLine lineNumber: Int) {
        print("Test failed at line \(lineNumber): \(testCase.name), \(description)")
    }
}
