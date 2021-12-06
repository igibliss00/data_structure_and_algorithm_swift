import Foundation

public struct Stack<Element> {
    var storage: [Element] = []
    
    public init() {}
    
    public mutating func push(_ element: Element) {
        storage.append(element)
    }
}

extension Stack: CustomStringConvertible {
    public var description: String {
        return storage
            .map { "\($0)" }
            .joined(separator: " ")
    }
}
