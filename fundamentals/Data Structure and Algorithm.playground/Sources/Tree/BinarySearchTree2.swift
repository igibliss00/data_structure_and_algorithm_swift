import Foundation

public class BinarySearchTree<T: Comparable> {
    public typealias Node = BinarySearchTree<T>
    fileprivate(set) public var value: T
    fileprivate(set) public var parent: Node?
    fileprivate(set) public var left: Node?
    fileprivate(set) public var right: Node?
    
    public init(value: T) {
        self.value = value
    }
    
    public convenience init(array: [T]) {
        precondition(array.count > 0)
        self.init(value: array.first!)
        for v in array.dropFirst() {
            insert(value: v)
        }
    }
    
    public var isRoot: Bool {
        return parent == nil
    }
    
    public var isLeaf: Bool {
        return left == nil && right == nil
    }
    
    public var isLeftChild: Bool {
        return parent?.left === self
    }
    
    public var isRightChild: Bool {
        return parent?.right === self
    }
    
    public var hasLeftChild: Bool {
        return left != nil
    }
    
    public var hasRightChild: Bool {
        return right != nil
    }
    
    public var hasAnyChild: Bool {
        return hasLeftChild || hasRightChild
    }
    
    public var hasBothChildren: Bool {
        return hasLeftChild && hasRightChild
    }
    
    public var count: Int {
        return (left?.count ?? 0) + 1 + (right?.count ?? 0)
    }
}

// MARK: - Adding Items
extension BinarySearchTree {
    public func insert(value: T) {
        if value < self.value {
            if let left = left {
                left.insert(value: value)
            } else {
                left = Node(value: value)
                left?.parent = self
            }
        } else {
            if let right = right {
                right.insert(value: value)
            } else {
                right = Node(value: value)
                parent = self
            }
        }
    }
}

extension BinarySearchTree {
    @discardableResult public func remove() -> Node? {
        let replacement: Node?

        if let right = right {
            replacement = right.minimum()
        } else if let left = left {
            replacement = left.maximum()
        } else {
            replacement = nil
        }
        
        replacement?.remove()
        
        replacement?.right = right
        replacement?.left = left
        right?.parent = replacement
        left?.parent = replacement
        reconnectParentTo(node: replacement)
        
        parent = nil
        left = nil
        right = nil
        
        return replacement
    }
    
    private func reconnectParentTo(node: Node?) {
        if let parent = parent {
            if isLeftChild {
                parent.left = node
            } else {
                parent.right = node
            }
        }
        
        node?.parent = parent
    }
    
    public func minimum() -> Node {
        var node = self
        while let next = node.left {
            node = next
        }
        
        return node
    }
    
    public func maximum() -> Node {
        var node = self
        while let next = node.right {
            node = next
        }
        
        return node
    }
}

// MARK: - Searching
extension BinarySearchTree {
    public func search(value: T) -> Node? {
        var node: Node? = self
        while let n = node {
            if value < n.value {
                node = n.left
            } else if value > n.value {
                node = n.right
            } else {
                return node
            }
        }
        
        return nil
    }
    
    public func contains(value: T) -> Bool {
        return search(value: value) != nil
    }
    
    public func depth() -> Int {
        var edge: Int = 0
        var node = self
        while let parent = node.parent {
            node = parent
            edge += 1
        }
        
        return edge
    }
    
    public func height() -> Int {
        if isLeaf {
            return 0
        } else {
            return 1 + max(left?.height() ?? 0, right?.height() ?? 0)
        }
    }
}
