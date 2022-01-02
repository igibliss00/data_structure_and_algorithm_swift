//import Foundation
//
//public struct EnhancedDoublyLinkedList<Element> {
//    private var headNode: DoublyLinkedNode?
//    private var tailNode: DoublyLinkedNode?
//    public private(set) var count: Int = 0
//    private var id = ID()
//    
//    public init() { }
//    fileprivate class ID {
//        init() { }
//    }
//}
//
//// MARK: - LinkedList Node
//extension EnhancedDoublyLinkedList {
//    fileprivate class DoublyLinkedNode {
//        public var value: Element
//        public var next: DoublyLinkedNode?
//        public weak var previous: DoublyLinkedNode?
//        
//        public init(value: Element) {
//            self.value = value
//        }
//    }
//}
//
//// MARK: - Initializers
//public extension EnhancedDoublyLinkedList {
//    private init(_ nodeChain: (head: DoublyLinkedNode, tail: DoublyLinkedNode, count: Int)?) {
//        guard let chain = nodeChain else {
//            return
//        }
//        
//        headNode = chain.head
//        tailNode = chain.tail
//        count = chain.count
//    }
//    
//    init<S>(_ elements: S) where S: Sequence, S.Element == Element {
//        if let linkedList = elements as? EnhancedDoublyLinkedList<Element> {
//            self = linkedList
//        } else {
////            self = LinkedList(chain(of: elements))
//        }
//    }
//}
//
//// MARK: - Chain of Nodes
//extension EnhancedDoublyLinkedList {
//    private func chain<S>(of sequence: S) -> (head: DoublyLinkedNode, tail: DoublyLinkedNode, count: Int)? where S: Sequence, S.Element == Element {
//        var iterator = sequence.makeIterator()
//        var head, tail: DoublyLinkedNode
//        var count: Int = 0
//        
//        guard let firstValue = iterator.next() else {
//            return nil
//        }
//        
//        var currentNode = DoublyLinkedNode(value: firstValue)
//        head = currentNode
//        count = 1
//        
//        while let nextValue = iterator.next() {
//            let newNode = DoublyLinkedNode(value: nextValue)
//            currentNode.next = newNode
//            newNode.previous = currentNode
//            currentNode = newNode
//            count += 1
//        }
//        
//        tail = currentNode
//        return (head: head, tail: tail, count: count)
//    }
//}
//
//// MARK: - Computed Properties
//public extension EnhancedDoublyLinkedList {
//    var head: Element? {
//        return headNode?.value
//    }
//    
//    var tail: Element? {
//        return tailNode?.value
//    }
//}
//
//
//// MARK: - Sequence Conformance
//extension EnhancedDoublyLinkedList: Sequence {
//    public typealias Element = Element
//    
//    public __consuming func makeIterator() -> Iterator {
//        return Iterator(node: headNode)
//    }
//    
//    public struct Iterator: IteratorProtocol {
//        fileprivate var currentNode: DoublyLinkedNode?
//        
//        fileprivate init(node: DoublyLinkedNode?) {
//            self.currentNode = node
//        }
//        
//        public mutating func next() -> Element? {
//            guard let node = currentNode else {
//                return nil
//            }
//            
//            currentNode = node.next
//            return node.value
//        }
//    }
//}
//
//extension EnhancedDoublyLinkedList: Collection {
//    public var startIndex: Index {
//        return Index(node: headNode, offset: 0, listID: id)
//    }
//    
//    public var endIndex: Index {
//        return Index(node: tailNode, offset: count, listID: id)
//    }
//    
//    public var first: Element? {
//        return head
//    }
//    
//    public var isEmpty: Bool {
//        return count == 0
//    }
//    
//    public func index(after i: Index) -> Index {
//        precondition(i.isMember(of: self), "LinkedList index is invalid")
//        precondition(i.offset != endIndex.offset, "LinkedList index is out of bounds")
//        return Index(node: i.node?.next, offset: i.offset + 1, listID: id)
//    }
//    
//    public struct Index: Comparable {
//        fileprivate weak var node: DoublyLinkedNode?
//        fileprivate var offset: Int
//        fileprivate weak var listID: ID?
//        
//        fileprivate init(node: DoublyLinkedNode?, offset: Int, listID: ID?) {
//            self.node = node
//            self.offset = offset
//            self.listID = listID
//        }
//        
//        fileprivate func isMember(of linkedList: EnhancedDoublyLinkedList) -> Bool {
//            return self.listID === linkedList.id
//        }
//        
//        public static func ==(lhs: Index, rhs: Index) -> Bool {
//            return lhs.offset == rhs.offset
//        }
//        
//        public static func <(lhs: Index, rhs: Index) -> Bool {
//            return lhs.offset < rhs.offset
//        }
//    }
//}
//
//extension EnhancedDoublyLinkedList: MutableCollection {
//    public subscript(position: Index) -> Element {
//        get {
//            precondition(position.isMember(of: self), "LinkedList index is invalid")
//            precondition(position.offset != endIndex.offset, "Index is out of range")
//            guard let node = position.node else {
//                preconditionFailure("LinkedList index is invalid")
//            }
//            
//            return node.value
//        }
//        
//        
//    }
//    
//    
//}
