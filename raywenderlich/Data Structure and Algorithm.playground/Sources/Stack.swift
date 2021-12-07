import Foundation

public struct Stack<Element: Equatable>: Equatable {
    private var storage: [Element] = []
    public var isEmpty: Bool {
        return peek() == nil
    }
    
    public init() {}
    
    public init(_ elements: [Element]) {
        storage = elements
    }
    
    public func peek() -> Element? {
        return storage.last
    }
    
    public mutating func push(_ element: Element) {
        storage.append(element)
    }
    
    @discardableResult
    public mutating func pop() -> Element? {
        return storage.popLast()
    }
}

extension Stack: CustomStringConvertible {
    public var description: String {
        return storage
            .map { "\($0)" }
            .joined(separator: " ")
    }
}

extension Stack: ExpressibleByArrayLiteral {
    public init(arrayLiteral elements: Element...) {
        storage = elements
    }
    
}
