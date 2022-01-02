import Foundation

// MARK: - Nodeable
public protocol Nodeable: AnyObject {
    associatedtype Value
    var value: Value { get set }
    var next: Self? { get set }
    init(value: Value, next: Self?)
}

extension Nodeable where Self.Value: Equatable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.value == rhs.value
    }
}

extension Nodeable {
    public var retainCount: Int {
        CFGetRetainCount(self as CFTypeRef)
    }
}

extension Nodeable where Self: CustomStringConvertible {
    public var description: String {
        return "{ value: \(value), next: \(next == nil ? "Nil" : "Exists")}"
    }
}
// MARK: - LinkedListable
public protocol LinkedListable where Node.Value == Value {
    associatedtype Node: Nodeable
    associatedtype Value
    var firstNode: Node? { get set }
    var lastNode: Node? { get set }
    init()
}

extension LinkedListable {
    public var firstValue: Value? {
        return firstNode?.value
    }
    
    public var lastValue: Value? {
        return lastNode?.value
    }
    
    public var isEmpty: Bool {
        return firstNode == nil
    }
}

// MARK: - Initializers
extension LinkedListable {
    public init(_ array: [Value]) {
        self.init()
        array.forEach { append(last: $0) }
    }
    
    public init(copyValuesFrom linkedList: Self) {
        self.init()
        if linkedList.isEmpty { return }
        linkedList.forEachNode { append(last: $0.value)  }
    }
    
    public init(copyReferencesFrom linkedList: Self) {
        self.init()
        firstNode = linkedList.firstNode
        lastNode = linkedList.lastNode
    }
}

// MARK: - Iteration
extension LinkedListable {
    public func node(at index: Int) -> Node? {
        if isEmpty {
            return nil
        }
        
        var currentIndex: Int = 0
        var resultNode: Node?
        forEachWhile { node in
            if currentIndex == index {
                resultNode = node
                return false
            } else {
                currentIndex += 1
                return true
            }
        }
        
        return resultNode
    }
    
    /// This function is to loop through the nodes conditionally.
    /// Usually used for finding a node because the loop stops when a certain condition is met.
    public func forEachWhile(closure: (Node) -> Bool) {
        var currentNode = self.firstNode
        while currentNode != nil {
            guard closure(currentNode!) else { return }
            currentNode = currentNode?.next
        }
    }
    
    /// This function is used for looping through the entire list without any condition.
    /// Usually used if need to get to the endIndex or for printing out the entire values for description
    /// Notice how the closure returns Void, unlike Bool in forEachWhile. This means that the closure is not for a condition, but for a task needed for each node while looping with no condition.
    public func forEachNode(closure: (Node) -> Void) {
        forEachWhile { closure($0); return true }
    }
}

// MARK: - Add/Get
extension LinkedListable {
    public func value(at index: Int) -> Value? {
        return node(at: index)?.value
    }
    
    public mutating func append(last value: Value) {
        let newNode = Node(value: value, next: nil)
        if firstNode == nil {
            firstNode = newNode
            lastNode = firstNode
        } else {
            lastNode?.next = newNode
            lastNode = lastNode?.next
        }
    }
}

// MARK: - CustomStringConvertible
extension LinkedListable where Self: CustomStringConvertible {
    public var description: String {
        var value = [String]()
        forEachNode { value.append("\($0.value)")}
        return value.joined(separator: ", ")
    }
}

// MARK: - ExpressibleByArrayLiteral
extension LinkedListable where Self: ExpressibleByArrayLiteral, ArrayLiteralElement == Value {
    public init(arrayLiteral elements: Self.ArrayLiteralElement...) {
        self.init(elements)
    }
}

// MARK: - Sequence
extension LinkedListable where Self: Sequence {
    public typealias Iterator = LinkedListIterator<Node>
    public func makeIterator() -> LinkedListIterator<Node> {
        return .init(firstNode)
    }
}

public struct LinkedListIterator<Node>: IteratorProtocol where Node: Nodeable {
    public var currentNode: Node?
    public init(_ firstNode: Node?) {
        self.currentNode = firstNode
    }
    
    public mutating func next() -> Node.Value? {
        let node = currentNode
        currentNode = currentNode?.next
        return node?.value
    }
}

// MARK: - Collection
extension LinkedListable where Self: Collection, Self.Index == Int, Self.Element == Value {
    public var startIndex: Index { 0 }
    public var endIndex: Index {
        guard !isEmpty else { return 0 }
        var currentIndex = 0
        forEachNode { _ in
            currentIndex += 1
        }
        return currentIndex
    }
    
    public func index(after i: Index) -> Index {
        i + 1
    }
    
    public subscript(position: Index) -> Element {
        node(at: position)!.value
    }
    
    public var isEmpty: Bool {
        return firstNode == nil
    }
}

// MARK: - MutableCollection
extension LinkedListable where Self: MutableCollection, Self.Index == Int, Self.Element == Value {
    public subscript(at index: Self.Index) -> Self.Element {
        get { node(at: index)!.value }
        set(newValue) { node(at: index)!.value = newValue }
    }
}

final public class LinkedListNode<Value>: Nodeable {
    public var value: Value
    public var next: LinkedListNode?
    public init(value: Value, next: LinkedListNode?) {
        self.value = value
        self.next = next
    }
}

extension LinkedListNode: Equatable, CustomStringConvertible where Value: Equatable {}

//final public class BaseLinkedList<Value>: LinkedListable where Value: Equatable {
//    public typealias Node = LinkedListNode<Value>
//    public var firstNode: LinkedListNode<Value>?
//    public weak var lastNode: LinkedListNode<Value>?
//    required public init() { }
//}
//
//extension BaseLinkedList: CustomStringConvertible, ExpressibleByArrayLiteral, Sequence, Collection, MutableCollection {
//
//}

public class BaseLinkedList<Value>: LinkedListable where Value: Equatable {
    public typealias Node = LinkedListNode<Value>
    public var firstNode: LinkedListNode<Value>?
    public weak var lastNode: LinkedListNode<Value>?
    required public init() { }
}

public class EnhancedLinkedList<Value>: BaseLinkedList<Value> where Value: Equatable {}
extension EnhancedLinkedList: CustomStringConvertible, ExpressibleByArrayLiteral, Sequence, Collection {}
