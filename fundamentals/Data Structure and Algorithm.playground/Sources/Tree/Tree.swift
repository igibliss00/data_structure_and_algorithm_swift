/*
 General Purpose Tree
 */

import Foundation

public class TreeNode<T> {
    public var value: T
    public var parent: TreeNode!
    public var children = [TreeNode]()
    
    public init(value: T) {
        self.value = value
    }
}

extension TreeNode where T: Equatable {
    public func addChild(_ value: T) {
        let node = TreeNode(value: value)
        addChild(node)
    }
    
    public func addChild(_ node: TreeNode<T>) {
        children.append(node)
        parent = self
    }
    
    public func search(_ value: T) -> TreeNode? {
        if value == self.value {
            return self
        }
        
        for child in children {
            if let found = search(child.value) {
                return found
            }
        }
        
        return nil
    }
}

extension TreeNode: CustomStringConvertible {
    public var description: String {
        var s = "\(value)"
        if !children.isEmpty {
            s += " {" + children.map { $0.description }.joined(separator: ", ") + " }"
        }
        
        return s
    }
}
