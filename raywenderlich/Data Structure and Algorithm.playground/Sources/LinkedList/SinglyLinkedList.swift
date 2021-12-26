import Foundation

public class Node<T: Equatable> {
    public var value: T
    public var next: Node<T>?

    public init(_ value: T) {
        self.value = value
    }
}

public class SinglyLinkedList<T: Equatable> {
    fileprivate var head: Node<T>?
    private var tail: Node<T>?

    var first: Node<T>? {
        return head
    }

    var last: Node<T>? {
        return tail
    }

    public var count: Int {
        var node = head
        var i = 0
        while node != nil {
            i += 1
            node = node!.next
        }

        return i
    }

    public init() { }

    public func append(_ value: T) {
        let node = Node(value)
        append(node)
    }

    public func find(value: T) -> Node<T>? {
        var node = head
        while node != nil {
            if node!.value == value {
                return node
            }

            node = node!.next
        }

        return node
    }

    public func find(index: Int) -> Node<T>? {
        guard index >= 0 && index < count else {
            return nil
        }

        var i = index
        var node = head
        while i > 0 {
            node = node?.next
            i -= 1
        }

        return node
    }

    public func deleteNode(index: Int) -> Node<T>? {
        if index == 0 {
            head = nil
            tail = nil

            return head
        } else {
            guard let node = find(index: index),
                  let prev = find(index: index - 1) else { return nil }

            if index == count - 1 {
                prev.next = nil
                tail = prev
            } else {
                prev.next = node.next
            }

            return node
        }
    }
}

extension SinglyLinkedList: CustomStringConvertible {
    public var description: String {
        var s = "[ "

        var node = head
        while node != nil {
            s += "\(node!.value)"
            node = node!.next

            if node != nil {
                s += ", "
            }
        }
        return s + " ]"
    }
}

extension SinglyLinkedList {
    private func append(_ node: Node<T>) {
        if head == nil {
            head = node
        }

        if let tail = tail {
            tail.next = node
        }

        tail = node
    }
}

extension SinglyLinkedList {
    var starIndex: SinglyLinkedListIndex<T>? {
        guard let head = head else { return nil }
        return SinglyLinkedListIndex(node: head, tag: 0)
    }

    var endIndex: SinglyLinkedListIndex<T>? {
        guard let tail = tail else { return nil }
        return SinglyLinkedListIndex(node: tail, tag: count - 1)
    }
}

class SinglyLinkedListIndex<T: Equatable>: Comparable {
    var node: Node<T>
    var tag: Int

    public init(node: Node<T>, tag: Int) {
        self.node = node
        self.tag = tag
    }

    static func == (lhs: SinglyLinkedListIndex<T>, rhs: SinglyLinkedListIndex<T>) -> Bool {
        if lhs.tag == rhs.tag {
            return true
        } else {
            return false
        }
    }

    static func < (lhs: SinglyLinkedListIndex<T>, rhs: SinglyLinkedListIndex<T>) -> Bool {
        if lhs.tag < rhs.tag {
            return true
        } else {
            return false
        }
    }
}
