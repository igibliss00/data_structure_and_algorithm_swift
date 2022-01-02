import Foundation

// MARK: - Nodable
public protocol TestNodable {
    associatedtype Value
    var value: Value { get set }
    var next: Self? { get set }
    init(value: Value, next: Self?)
}

extension TestNodable where Self.Value: Equatable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.value == rhs.value
    }
}

extension TestNodable {
    public var retainCount: Int {
        CFGetRetainCount(self as CFTypeRef)
    }
}

extension TestNodable where Self: CustomStringConvertible {
    public var description: String {
        return "{ value: \(value), next: \(next == nil ? "Nil" : "Exists")}"
    }
}

// MARK: - Linkable
public protocol TestLinkable where Node.Value == Value {
    associatedtype Node: TestNodable
    associatedtype Value
    var firstNode: Node? { get set }
    var lastNode: Node? { get set }
    init()
}

extension TestLinkable {
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
extension TestLinkable {
    init(_ array: [Value]) {
        self.init()
        array.forEach { append($0) }
    }
    
    init(copyValuesFrom linkedList: Self) {
        self.init()
        guard linkedList.isEmpty else { return }
        linkedList.forEachNode { append($0) }
    }
    
    init(copyReferenceFrom linkedList: Self) {
        self.init()
        firstNode = linkedList.firstNode
        lastNode = linkedList.lastNode
    }
}

// MARK: - Iterations
extension TestLinkable {
    public func node(_ index: Int) -> Node? {
        guard !isEmpty else { return nil }
        
        var currentIndex = 0
        var currentNode: Node?
        forEachWhile { node in
            if currentIndex == index {
                currentNode = node
                return false
            } else {
                currentIndex += 1
                return true
            }
        }
        
        return currentNode
    }
    
    public func forEachWhile(closure: (Node) -> Bool) {
        var currentNode = firstNode
        
        while currentNode != nil {
            guard closure(currentNode!) else { return }
            currentNode = currentNode?.next
        }
    }
    
    public func forEachNode(closure: (Node) -> Void) {
        forEachWhile { closure($0); return true }
    }
}

extension TestLinkable {
    public mutating func append(_ value: Value) {
        let node = Node(value: value, next: nil)
        append(node)
    }
    
    public mutating func append(_ node: Node) {
        if firstNode == nil {
            firstNode = node
            lastNode = node
        } else {
            lastNode?.next = node
            lastNode = node
        }
    }
}

extension TestLinkable where Self:ExpressibleByArrayLiteral, ArrayLiteralElement == Value {
    init(arrayLiteral elements: ArrayLiteralElement...) {
        self.init(elements)
    }
}

extension TestLinkable where Self: Sequence {
    public typealias Iterator = TestIterator<Node>
    public func makeIterator() -> TestIterator<Node> {
        return .init(firstNode)
    }
}

public struct TestIterator<Node>: IteratorProtocol where Node: TestNodable {
    var currentNode: Node?
    public init(_ firstNode: Node?) {
        currentNode = firstNode
    }
    
    public mutating func next() -> Node.Value? {
        let node = currentNode
        currentNode = node?.next
        return node?.value
    }
}

extension TestLinkable where Self: Collection, Self.Index == Int, Self.Element == Value {
    public var startIndex: Index {
        return 0
    }
    
    public var endIndex: Index {
        guard !isEmpty else { return 0 }
        var currentIndex = 0
        forEachNode { _ in
            currentIndex += 1
        }
        
        return currentIndex
    }
    
    public func index(after index: Index) -> Index {
        index + 1
    }
    
    public subscript(position: Index) -> Element {
        node(position)!.value
    }
}
