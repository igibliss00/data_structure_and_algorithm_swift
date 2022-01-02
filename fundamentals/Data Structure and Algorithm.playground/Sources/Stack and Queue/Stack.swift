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

struct StringWrapper: Equatable {
    var value: Character
}

public struct Linter {
    var stack = Stack<StringWrapper>()
    
    public init() {}
    
    public mutating func lint(_ text: String) -> String {
        for (index, char) in text.enumerated() {
            if isOpeningBrace(char) {
                let wrapper = StringWrapper(value: char)
                stack.push(wrapper)
            } else if isClosingBrace(char) {
                if getOpeningBrace(of: char) == getMostRecentOpeningBrace() {
                    stack.pop()
                } else {
                    return "Incorrect closing brace: \(char) at index \(index)"
                }
            }
        }
        
        if stack.isEmpty {
            return "No error found"
        } else {
            return "\(getMostRecentOpeningBrace()!) does not have a closing brace"
        }
    }
    
    private func isOpeningBrace(_ char: Character) -> Bool {
        return ["(", "[", "{"].contains(char)
    }
    
    private func isClosingBrace(_ char: Character) -> Bool {
        return [")", "]", "}"].contains(char)
    }
    
    private func getMostRecentOpeningBrace() -> Character? {
        return stack.peek()?.value
    }
    
    private func getOpeningBrace(of brace: Character) -> Character? {
        switch brace {
            case ")":
                return "("
            case "]":
                return "["
            case "}":
                return "{"
            default:
                return nil
        }
    }
}
