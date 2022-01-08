import Foundation
import PlaygroundSupport
import XCTest

final class StackTestCase: XCTestCase {
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

final class FirstBinaryTreeTestCase: XCTestCase {
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
    
    func test_traversePreOrder() {
        var testArr: [Int] = []
        tree.traversePreOrder { testArr.append($0) }
        XCTAssertEqual(testArr, [7, 1, 0, 5, 9, 8])
    }
    
    func trest_traversePostOrder() {
        var testArr: [Int] = []
        tree.traversePostOrder { testArr.append($0) }
        XCTAssertEqual(testArr, [0, 5, 1, 8, 9, 7])
    }
    
    func test_binarySearch() {
        let array = [1, 5, 18, 32, 33, 33, 47, 502]
        XCTAssertEqual(array.binarySearch(for: 5), 1)
    }
}

final class SecondBinaryTreeTestCase: XCTestCase {
    var tree: BinaryTree<Int>!
    
    override func setUp() {
        let leftChild = BinaryTree<Int>.Node<Int>(value: 10)
        let rightChild = BinaryTree<Int>.Node<Int>(value: 30)
        let parent = BinaryTree<Int>.Node<Int>(value: 20, leftChild: leftChild, rightChild: rightChild)
        tree = BinaryTree<Int>(rootNode: parent)
    }
    
    func test_binarySearch() {
        let node = tree.searchTree(30, node: tree.rootNode)
        XCTAssertEqual(node?.value, 30)
    }
    
    func test_binaryTreeInsert() {
        tree.insert(40, existingNode: tree.rootNode)
        let node = tree.searchTree(40, node: tree.rootNode)
        XCTAssertEqual(node?.value, 40)
    }
    
    func test_binaryTreeInOrderTraversal() {
        let list = tree.traverse(tree.rootNode)
        XCTAssertEqual(list, [10, 20, 30])
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

final class PersonNetworkTestCase: XCTestCase {
    var alice: Person!
    var bob: Person!
    var fred: Person!
    var helen: Person!
    var candy: Person!
    var derek: Person!
    var gina: Person!
    var irena: Person!
    var elaine: Person!
    
    override func setUp() {
        alice = Person(name: "Alice")
        bob = Person(name: "Bob")
        fred = Person(name: "Fred")
        helen = Person(name: "Helen")
        candy = Person(name: "Candy")
        derek = Person(name: "Derek")
        gina = Person(name: "Gina")
        irena = Person(name: "Irena")
        elaine = Person(name: "Elaine")
        
        alice.addFriend(bob)
        bob.addFriend(fred)
        fred.addFriend(helen)
        alice.addFriend(candy)
        alice.addFriend(derek)
        alice.addFriend(elaine)
        derek.addFriend(gina)
        gina.addFriend(irena)
    }
    
    func test_treeTraversal() {
        alice.displayNetwork()
    }
}

final class SortTestCase: XCTestCase {
    let data = [3, 12, 4, 2, 1, 7, 11, 5]
    let sortedData = [1, 2, 3, 4, 5, 7, 11, 12]
    
    func test_bubbleSort() {
        let bubbleSort = BubbleSort<Int>()
        let sorted = bubbleSort.sort(data, <)
        XCTAssertEqual(sorted, sortedData)
        
        checkSortAlgorithm(bubbleSort.sort2)
    }
    
    func test_selectionSort() {
        let selectionSort = SelectionSort<Int>()
        let sorted = selectionSort.sort(data, <)
        XCTAssertEqual(sorted, sortedData)
        
        checkSortAlgorithm(selectionSort.sort2)
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
    func test_sortableArray() {
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
    
    func testQuickSort() {
        checkSortAlgorithm(quicksort)
    }
    
    fileprivate typealias QuicksortFunction = (inout [Int], _ low: Int, _ high: Int) -> Void

    fileprivate func checkQuicksort(_ function: QuicksortFunction) {
        checkSortAlgorithm { (a: [Int]) -> [Int] in
            var b = a
            function(&b, 0, b.count - 1)
            return b
        }
    }
    
    func testQuicksortLomuto() {
        checkQuicksort(quicksortLomuto)
    }
    
    func testQuicksortHoare() {
        checkQuicksort(quicksortHoare)
    }
    
    func testQuicksortRandom() {
        checkQuicksort(quicksortRandom)
    }
}

final class LinkListTestCase: XCTestCase {
    func test_doublyLinkedList() {
        let linkedList = LinkedList<Int>()
        for i in stride(from: 0, to: 100, by: 10) {
            linkedList.append(i)
        }
        
        let startIndex = linkedList.startIndex
        let expectedStartIndex = LinkedListIndex<Int>(node: linkedList.head, tag: 0)
        XCTAssertEqual(startIndex, expectedStartIndex)
        
        let endIndex = linkedList.endIndex
        let expectedEndIndex = LinkedListIndex<Int>(node: linkedList.last, tag: 10)
        XCTAssertEqual(endIndex, expectedEndIndex)
        
        let node = linkedList.node(at: 5)
        let testIndex = linkedList.index(after: LinkedListIndex<Int>(node: node, tag: 5))
        let next = linkedList.node(at: 6)
        let expectedTestIndex = LinkedListIndex<Int>(node: next, tag: 6)
        XCTAssertEqual(testIndex, expectedTestIndex)
        
        let random = linkedList.randomElement()
        XCTAssertNotNil(random)
    }
    
    func test_singlyLinkedList() {
        let linkedList = SinglyLinkedList<Int>()
        for i in stride(from: 10, to: 100, by: 10) {
            linkedList.append(i)
        }

        let foundNode = linkedList.find(index: 3)
        XCTAssertEqual(foundNode?.value, 40)

        let deleted0 = linkedList.deleteNode(index: 7)
        XCTAssertEqual(deleted0?.value, 80)
        XCTAssertEqual(linkedList.description, "[ 10, 20, 30, 40, 50, 60, 70, 90 ]")
        let deleted1 = linkedList.deleteNode(index: 3)
        XCTAssertEqual(deleted1?.value, 40)
        XCTAssertEqual(linkedList.description, "[ 10, 20, 30, 50, 60, 70, 90 ]")
        let deleted2 = linkedList.deleteNode(index: 0)
        XCTAssertEqual(deleted2?.value, 10)
        XCTAssertEqual(linkedList.description, "[  ]")
    }
    
    func test_baseLinkedList() {
        var linkedList = BaseLinkedList<String>(["one", "two", "three"])
        linkedList = BaseLinkedList<String>(copyReferencesFrom: linkedList)
        linkedList = BaseLinkedList<String>(copyValuesFrom: linkedList)

        var node = linkedList.firstNode
        XCTAssertEqual(node?.value, "one")

        node = linkedList.lastNode
        XCTAssertEqual(node?.value, "three")

        XCTAssertFalse(linkedList.isEmpty)

        linkedList.append(last: "four")
        XCTAssertEqual(linkedList.lastValue, "four")
    }
    
    func test_enhancedLinkedList() {
        let linkedList = EnhancedLinkedList(arrayLiteral: "one", "two", "three")
        let mapped = linkedList.map { $0 + "!" }
        let expectedMap = ["one!", "two!", "three!"]
        XCTAssertEqual(mapped, expectedMap)
        
        let reduced = linkedList.reduce("", { "\($0)_\($1)" })
        let expectedReduce = "_one_two_three"
        XCTAssertEqual(reduced, expectedReduce)
        XCTAssertEqual(linkedList.count, 3)
        
        let found = linkedList.index(after: linkedList.startIndex)
        print(found)
    }
}

final class HeapTestCase: XCTestCase {
    func test_min_heap() {
        checkHeap(Heap<Int>.self, orderCriteria: "<")
    }
    
    func test_max_heap() {
        checkHeap(Heap<Int>.self, orderCriteria: ">")
    }
    
    func test_insert_heap() {
        
    }
}

final class HashTableTest: XCTestCase {
    func test_HashTable() {
        var hashTable = HashTable<String, String>(capacity: 3)
        XCTAssertTrue(hashTable.isEmpty)
        
        hashTable["Apple"] = "iPhone"
        hashTable.updateValue("Galaxy", forKey: "Samsung")
        hashTable["Neo"] = "Tom"
        hashTable["One"] = "Foolery"
        
        XCTAssertEqual(4, hashTable.count)
        let removed = hashTable.removeValue(forKey: "Neo")
        XCTAssertEqual(removed, "Tom")
        XCTAssertEqual(3, hashTable.count)
    }
}

final class HashSetTest: XCTestCase {
    func test_hashSet() {
        var hashSet = HashSet<String>()
        XCTAssertTrue(hashSet.isEmpty)
        
        hashSet.insert("one")
        hashSet.insert("two")
        hashSet.insert("three")
        hashSet.insert("four")
        hashSet.insert("five")
        hashSet.insert("six")
        hashSet.insert("seven")
        
        let elements = hashSet.allElements()
        XCTAssertEqual(elements.count, 7)
        XCTAssertEqual(hashSet.count, 7)
        
        let isContains = elements.contains("two")
        XCTAssertTrue(isContains)
        
        let isNotContains = elements.contains("eleven")
        XCTAssertFalse(isNotContains)
        
        hashSet.remove("four")
        XCTAssertEqual(hashSet.count, 6)
        
        var otherSet = HashSet<String>()
        otherSet.insert("twenty")
        otherSet.insert("twentyOne")
        
        let combined = hashSet.union(otherSet)
        XCTAssertEqual(combined.count, 8)
        
        otherSet.insert("two")
        
        let common = hashSet.intersect(otherSet)
        XCTAssertEqual(common.count, 1)
        XCTAssertFalse(common.isEmpty)
        
        let difference = hashSet.difference(otherSet)
        XCTAssertEqual(difference.count, 5)
    }
    
    func test_hashSetEnhanced() {
        var hashSet = HashSetEnhanced<String>(capacity: 20)
        XCTAssertTrue(hashSet.isEmpty)
        
        hashSet.insert("one")
        hashSet.insert("two")
        hashSet.insert("three")
        hashSet.insert("four")
        hashSet.insert("five")
        hashSet.insert("six")
        hashSet.insert("seven")
        
        let elements = hashSet.allElements()
        XCTAssertEqual(elements.count, 7)
        XCTAssertEqual(hashSet.count, 7)
        
        let isContains = elements.contains("two")
        XCTAssertTrue(isContains)
        
        let isNotContains = elements.contains("eleven")
        XCTAssertFalse(isNotContains)
        
        hashSet.remove("four")
        XCTAssertEqual(hashSet.count, 6)
    }
    
    func test_orderedSet() {
        let set = OrderedSet<Int>()
        XCTAssertTrue(set.isEmpty)
        for i in stride(from: 0, to: 5, by: 1) {
            set.add(i)
        }
        set.insert(50, index: 3)
        
        XCTAssertEqual(set.all(), [0, 1, 2, 50, 3, 4])
        
        set.remove(0)
        XCTAssertEqual(set.count, 5)
        XCTAssertEqual(set.all(), [1, 2, 50, 3, 4])
        XCTAssertEqual(set.object(at: 2), 50)
    }
    
    func test_multiSet() {
        var set = Multiset<Int>()
        for i in stride(from: 0, through: 5, by: 1) {
            set.add(i)
        }
        
        for _ in 0...2 {
            set.add(3)
        }
                
        let otherSet = Multiset<Int>([1, 3, 4])
        XCTAssertFalse(set.isSubset(of: otherSet))
        XCTAssertTrue(otherSet.isSubset(of: set))
        
        let set3 = Multiset<Int>([])
        // An empty set is always the subset of everything
        XCTAssertTrue(set3.isSubset(of: set))
        
        let set4: Multiset<String> = ["hello"]
        let set5 = Multiset<String>(set4.allItems)
        XCTAssertTrue(set4 == set5)
    }
}

final class GeneralTreeTest: XCTestCase {
    func test_Tree() {
        let one = TreeNode<Int>(value: 1)
        let two = TreeNode<Int>(value: 2)
        let three = TreeNode<Int>(value: 3)
        let four = TreeNode<Int>(value: 4)
        
        one.addChild(two)
        one.addChild(three)
        two.addChild(four)
        XCTAssertEqual("1 {2 {4 }, 3 }", one.description)
//        let found = one.search(2)
//        print("found", found)
    }
}

final class BreadthFirstSearchTest: XCTestCase {
    func test_search() {
        let tree = BFSGraph()
        
        let nodeA = tree.addNode("a")
        let nodeB = tree.addNode("b")
        let nodeC = tree.addNode("c")
        let nodeD = tree.addNode("d")
        let nodeE = tree.addNode("e")
        let nodeF = tree.addNode("f")
        let nodeG = tree.addNode("g")
        let nodeH = tree.addNode("h")
        
        tree.addEdge(nodeA, neighbor: nodeB)
        tree.addEdge(nodeA, neighbor: nodeC)
        tree.addEdge(nodeB, neighbor: nodeD)
        tree.addEdge(nodeB, neighbor: nodeE)
        tree.addEdge(nodeC, neighbor: nodeF)
        tree.addEdge(nodeC, neighbor: nodeG)
        tree.addEdge(nodeE, neighbor: nodeH)
        
        let nodesExplored = breadthFirstSearch(tree)
        
        XCTAssertEqual(nodesExplored, ["a", "b", "c", "d", "e", "f", "g", "h"])
    }
}

// Call Tests
//TestRunner().runTests(testClass: StackTestCase.self)
//TestRunner().runTests(testClass: FirstBinaryTreeTestCase.self)
//TestRunner().runTests(testClass: SecondBinaryTreeTestCase.self)
//TestRunner().runTests(testClass: AdjacencyListGraphTestCase.self)
//TestRunner().runTests(testClass: SortTestCase.self)
//TestRunner().runTests(testClass: LinterTestCase.self)
//TestRunner().runTests(testClass: QueueTestCase.self)
//TestRunner().runTests(testClass: QuicksortTest.self)
//TestRunner().runTests(testClass: LinkListTestCase.self)
//TestRunner().runTests(testClass: PersonNetworkTestCase.self)
//TestRunner().runTests(testClass: HeapTestCase.self)
//TestRunner().runTests(testClass: HashTableTest.self)
//TestRunner().runTests(testClass: HashSetTest.self)
//TestRunner().runTests(testClass: GeneralTreeTest.self)
TestRunner().runTests(testClass: BreadthFirstSearchTest.self)


class PlaygroundTestObserver: NSObject, XCTestObservation {
    @objc func testCase(_ testCase: XCTestCase, didFailWithDescription description: String, inFile filePath: String?, atLine lineNumber: Int) {
        print("Test failed at line \(lineNumber): \(testCase.name), \(description)")
    }
}
