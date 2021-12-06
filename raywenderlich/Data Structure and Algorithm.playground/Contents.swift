import Foundation
import PlaygroundSupport
import XCTest

class StackTests: XCTestCase {
    override class func setUp() {
        
    }
    
    override class func tearDown() {
        
    }
    
    func test_ShouldFail() {
        XCTFail("You must fail to succeed.")
    }
    
    func test_ShouldPass() {
        var stack = Stack<Int>()
        stack.push(10)
        
        print("stack.description", stack.description)
        XCTAssertEqual("10", stack.description, "should evaluate to 10")
    }
}


// Call Tests
TestRunner().runTests(testClass: StackTests.self)

class PlaygroundTestObserver: NSObject, XCTestObservation {
    @objc func testCase(_ testCase: XCTestCase, didFailWithDescription description: String, inFile filePath: String?, atLine lineNumber: Int) {
        print("Test failed at line \(lineNumber): \(testCase.name), \(description)")
    }
}
