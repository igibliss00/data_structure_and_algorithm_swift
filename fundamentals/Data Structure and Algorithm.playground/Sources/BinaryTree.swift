import Foundation

public class BinaryNode<Element> {
    var value: Element
    public var leftChild: BinaryNode?
    public var rightChild: BinaryNode?
    
    public init(_ value: Element) {
        self.value = value
    }
}

extension BinaryNode {
    public func traverseInOrder(visit: (Element) -> Void) {
        leftChild?.traverseInOrder(visit: visit)
        visit(value)
        rightChild?.traverseInOrder(visit: visit)
    }
    
    public func traversePreOrder(visit: (Element) -> Void) {
        visit(value)
        leftChild?.traversePreOrder(visit: visit)
        rightChild?.traversePreOrder(visit: visit)
    }
    
    public func traversePostOrder(visit: (Element) -> Void) {
        leftChild?.traversePostOrder(visit: visit)
        rightChild?.traversePostOrder(visit: visit)
        visit(value)
    }
}

extension BinaryNode: CustomStringConvertible {
    public var description: String {
        return diagram(for: self)
    }
    
    private func diagram(for node: BinaryNode?,
                         _ top: String = "",
                         _ root: String = "",
                         _ bottom: String = "") -> String {
        
        guard let node = node else {
            return root + "nil\n"
        }
        
        if node.leftChild == nil && node.rightChild == nil {
            return root + "\(node.value)\n"
        }
        
        return diagram(for: node.rightChild, top + " ", top + "┌", top + "|")
        + root + "\(node.value)\n"
            + diagram(for: node.leftChild, bottom + "|", bottom + "└", bottom + " ")
    }
}

// Example from Data Structure and Algorithms book
public final class BinaryTree<T: Comparable> {
    public final class Node<T> {
        public var value: T
        public var leftChild: Node<T>?
        public var rightChild: Node<T>?
        
        public init(value: T, leftChild: Node<T>? = nil, rightChild: Node<T>? = nil) {
            self.value = value
            self.leftChild = leftChild
            self.rightChild = rightChild
        }
    }
    
    public var rootNode: Node<T>
    public var list = [T]()
    
    public init(rootNode: Node<T>) {
        self.rootNode = rootNode
    }
    
    public func addNodes(to parent: Node<T>, leftChild: Node<T>?, rightChild: Node<T>?) {
        parent.leftChild = leftChild
        parent.rightChild = rightChild
    }
    
    public func searchTree(_ value: T, node: Node<T>?) -> Node<T>? {
        if node == nil || value == node?.value {
            return node
        } else if value < node!.value {
            return searchTree(value, node: node?.leftChild)
        } else {
            return searchTree(value, node: node?.rightChild)
        }
    }
    
    public func insert(_ value: T, existingNode: Node<T>) {
        guard value != existingNode.value else {
            print("The same node already exists")
            return
        }
        
        if value < existingNode.value {
            if existingNode.leftChild == nil {
                existingNode.leftChild = Node(value: value)
            } else {
                insert(value, existingNode: existingNode.leftChild!)
            }
        } else {
            if existingNode.rightChild == nil {
                existingNode.rightChild = Node(value: value)
            } else {
                insert(value, existingNode: existingNode.rightChild!)
            }
        }
    }
    
    @discardableResult
    public func traverse(_ node: Node<T>?) -> [T]? {
        guard node != nil else {
            return nil
        }
        
        traverse(node?.leftChild)
        if let node = node {
            list.append(node.value)
        }
        traverse(node?.rightChild)
        
        return list
    }
}
