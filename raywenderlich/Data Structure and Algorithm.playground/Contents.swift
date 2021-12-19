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

final class LinterTestCase: XCTestCase {
    var linter = Linter()
    
    func test_Linter() {
        let message = linter.lint("( var x = { y: [1, 2, 3] } )")
        XCTAssertEqual(message, "No error found")
        
        let message2 = linter.lint("( var x = { y: [1, 2, 3] ) }")
        XCTAssertEqual(message2, "Incorrect closing brace: ) at index 25")
        
        let message3 = linter.lint("( var x = { y: [1, 2, 3] }")
        XCTAssertEqual(message3, "( does not have a closing brace")
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

final class AdjacencyListGraphTestCase: XCTestCase {
    var fromVertex: Vertex<Int>!
    var toVertex: Vertex<Int>!
    var edge: Edge<Int>!

    func test_vertex() {
        fromVertex = Vertex(data: 1, index: 0)
        XCTAssertEqual(fromVertex.description, "0: 1")

        toVertex = Vertex(data: 1, index: 1)
        XCTAssertEqual(toVertex.description, "1: 1")
        XCTAssertTrue(fromVertex != toVertex)
    }

    func test_edge() {
        fromVertex = Vertex(data: 1, index: 0)
        toVertex = Vertex(data: 1, index: 1)

        edge = Edge(from: fromVertex, to: toVertex, weight: 10)
        XCTAssertEqual(edge.description, "0: 1 - 10.0 -> 1: 1")

        let edge2 = Edge(from: toVertex, to: fromVertex, weight: 20)
        XCTAssertTrue(edge != edge2)
    }

    func test_adjacencyList() {
        let graph = AdjacencyListGraph<String>()

        let a = graph.createVertex("a")
        XCTAssertEqual(a.data, "a")
        XCTAssertTrue(graph.vertices.count == 1)

        let b = graph.createVertex("b")
        XCTAssertEqual(b.data, "b")
        XCTAssertTrue(graph.vertices.count == 2)

        let c = graph.createVertex("c")
        XCTAssertEqual(c.data, "c")
        XCTAssertTrue(graph.vertices.count == 3)

        graph.addDirectedEdge(a, to: b, withWeight: 1.0)
        graph.addDirectedEdge(b, to: c, withWeight: 2.0)
        graph.addDirectedEdge(a, to: c, withWeight: -5.5)

        let expectedValue = "a -> [(b: 1.0), (c: -5.5)]\nb -> [(c: 2.0)]"
        XCTAssertEqual(graph.description, expectedValue)
    }

    func test_adjacencyMatrix() {
        let graph = AdjacencyMatrixGraph<String>()

        let a = graph.createVertex("a")
        XCTAssertEqual(a.data, "a")
        XCTAssertTrue(graph.vertices.count == 1)

        let b = graph.createVertex("b")
        XCTAssertEqual(b.data, "b")
        XCTAssertTrue(graph.vertices.count == 2)

        let c = graph.createVertex("c")
        XCTAssertEqual(c.data, "c")
        XCTAssertTrue(graph.vertices.count == 3)

        graph.addDirectedEdge(a, to: b, withWeight: 1.0)
        graph.addDirectedEdge(b, to: c, withWeight: 2.0)

        let expectedValue = "  ø   1.0   ø  \n  ø    ø   2.0 \n  ø    ø    ø  "
        XCTAssertEqual(graph.description, expectedValue)
    }
}

final class SortTestCase: XCTestCase {
    let data = [3, 12, 4, 2, 1, 7, 11, 5]
    let sortedData = [1, 2, 3, 4, 5, 7, 11, 12]
    func test_bubbleSort() {
        let bubbleSort = BubbleSort<Int>()
        let sorted = bubbleSort.sort(data, <)
        XCTAssertEqual(sorted, sortedData)
    }
    
    func test_selectionSort() {
        let selectionSort = SelectionSort<Int>()
        let sorted = selectionSort.sort(data, <)
        XCTAssertEqual(sorted, sortedData)
    }
    
    func test_inserSort() {
        let insertSort = InsertSort<Int>()
        let sorted = insertSort.sort(data)
        XCTAssertEqual(sorted, sortedData)
        
        let sorted2 = insertSort.sort(data, >)
        XCTAssertEqual(sorted2, [12, 11, 7, 5, 4, 3, 2, 1])
    }
}

final class QueueTestCase: XCTestCase {
    func test_queue() {
        var queue = Queue<Int>()
        queue.enqueue(10)
        queue.enqueue(20)
        queue.enqueue(30)
        queue.enqueue(40)
        
        let count = queue.count
        XCTAssertEqual(count, 4)
        XCTAssertEqual(queue.isEmpty, false)
        XCTAssertEqual(queue.front, 10)
        
        let firstDequeued = queue.dequeue()
        let secondDequeued = queue.dequeue()
        XCTAssertEqual(firstDequeued, 10)
        XCTAssertEqual(secondDequeued, 20)
    }
    
    func test_enhancedQueue() {
        var queue = EnhancedQueue<Int>()
        queue.enqueue(10)
        queue.enqueue(20)
        queue.enqueue(30)
        queue.enqueue(40)
        
        let count = queue.count
        XCTAssertEqual(count, 4)
        XCTAssertEqual(queue.isEmpty, false)
        XCTAssertEqual(queue.front, 10)
        
        let firstDequeued = queue.dequeue()
        let secondDequeued = queue.dequeue()
        XCTAssertEqual(firstDequeued, 10)
        XCTAssertEqual(secondDequeued, 20)
    }
}

final class QuicksortTest: XCTestCase {
    func test_quicksort() {
        let array = [0, 5, 2, 1, 6, 3]
        var sortableArray = SortableArray<Int>(array)
        guard let sorted = sortableArray.quicksort(0, array.count - 1) else {
            return
        }
        
        XCTAssertEqual(sorted, [0, 1, 2, 3, 5, 6])
    }
    
    func test_quickSelect() {
        let array = [0, 50, 20, 10, 60, 30]
        var sortableArray = SortableArray<Int>(array)
        let value = sortableArray.quickSelect(kthLowestValue: 1, leftIndex: 0, rightIndex: array.count - 1)
        XCTAssertEqual(value, 30)
    }
}

// Call Tests
//TestRunner().runTests(testClass: StackTests.self)
//TestRunner().runTests(testClass: BinaryTreeTestCase.self)
//TestRunner().runTests(testClass: BinarySearchTestCase.self)
//TestRunner().runTests(testClass: AdjacencyListGraphTestCase.self)
//TestRunner().runTests(testClass: SortTestCase.self)
//TestRunner().runTests(testClass: LinterTestCase.self)
//TestRunner().runTests(testClass: QueueTestCase.self)
TestRunner().runTests(testClass: QuicksortTest.self)

class PlaygroundTestObserver: NSObject, XCTestObservation {
    @objc func testCase(_ testCase: XCTestCase, didFailWithDescription description: String, inFile filePath: String?, atLine lineNumber: Int) {
        print("Test failed at line \(lineNumber): \(testCase.name), \(description)")
    }
}
