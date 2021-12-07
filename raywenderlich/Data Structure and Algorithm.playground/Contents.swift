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

// Call Tests
TestRunner().runTests(testClass: StackTests.self)

class PlaygroundTestObserver: NSObject, XCTestObservation {
    @objc func testCase(_ testCase: XCTestCase, didFailWithDescription description: String, inFile filePath: String?, atLine lineNumber: Int) {
        print("Test failed at line \(lineNumber): \(testCase.name), \(description)")
    }
}
