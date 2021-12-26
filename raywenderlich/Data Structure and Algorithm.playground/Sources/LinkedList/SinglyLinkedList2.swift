import Foundation

protocol Nodeable: AnyObject {
    associatedtype Value
    var value: Value { get set }
    var next: Self? { get set }
    init(value: Value, next: Self?)
}

extension Nodeable where Self.Value: Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.value == rhs.value
    }
}

extension Nodeable {
    var retainCount: Int {
        CFGetRetainCount(self as CFTypeRef)
    }
}

extension Nodeable where Self: CustomStringConvertible {
    var description: String {
        return "{ value: \(value), next: \(next == nil ? "Nil" : "Exists")}"
    }
}

protocol LinkedListable where Node.Value == Value {
    associatedtype Node: Nodeable
    associatedtype Value
    var firstNode: Node? { get set }
    var lastNode: Node? { get set }
    init()
}

extension LinkedListable {
    var firstValue: Value? {
        return firstNode?.value
    }
    
    var lastValue: Value? {
        return lastNode?.value
    }
    
    var isEmpty: Bool {
        return firstNode == nil
    }
}

// MARK: - Initializers
extension LinkedListable {
    init(_ array: [Value]) {
        self.init()
        array.forEach { append(last: $0) }
    }
    
    init(copyValuesFrom linkedList: Self) {
        self.init()
        if linkedList.isEmpty { return }
        linkedList.forEachNode { append(last: $0.value)  }
    }
    
    init(copyReferencesFrom linkedList: Self) {
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
    
    func forEachWhile(closure: (Node) -> Bool) {
        var currentNode = self.firstNode
        while currentNode != nil {
            guard closure(currentNode!) else { return }
            currentNode = currentNode?.next
        }
    }
    
    func forEachNode(closure: (Node) -> Void) {
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
    var description: String {
        var value = [String]()
        forEachNode { value.append("\($0.value)")}
        return value.joined(separator: ", ")
    }
}

// MARK: - ExpressibleByArrayLiteral
extension LinkedListable where Self: ExpressibleByArrayLiteral, ArrayLiteralElement == Value {
    init(arrayLiteral elements: Self.ArrayLiteralElement...) {
        self.init(elements)
    }
}

// MARK: - Sequence
extension LinkedListable where Self: Sequence {
    typealias Iterator = LinkedListIterator<Node>
    func makeIterator() -> LinkedListIterator<Node> {
        return .init(firstNode)
    }
}

struct LinkedListIterator<Node>: IteratorProtocol where Node: Nodeable {
    var currentNode: Node?
    init(_ firstNode: Node?) {
        self.currentNode = firstNode
    }
    
    mutating func next() -> Node.Value? {
        let node = currentNode
        currentNode = currentNode?.next
        return node?.value
    }
}

// MARK: - Collection
extension LinkedListable where Self: Collection, Self.Index == Int, Self.Element == Value {
    var startIndex: Index { 0 }
    var endIndex: Index {
        guard !isEmpty else { return 0 }
        var currentIndex = 0
        forEachNode { _ in
            currentIndex += 1
        }
        return currentIndex
    }
    
    func index(after i: Index) -> Index {
        i + 1
    }
    subscript(position: Index) -> Element {
        node(at: position)!.value
    }
    
}
