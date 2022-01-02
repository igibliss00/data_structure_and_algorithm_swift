import Foundation

public struct Multiset<Element: Hashable> {
    private var storage: [Element: UInt] = [:]
    public private(set) var count: UInt = 0
    
    public init() { }
    
    public init<C: Collection>(_ collection: C) where C.Element == Element {
        for element in collection {
            self.add(element)
        }
    }
    
    public mutating func add(_ element: Element) {
        storage[element, default: 0] += 1
        count += 1
    }
    
    public mutating func remove(_ element: Element) {
        guard let currentCount = storage[element] else { return }
        if currentCount > 0 {
            storage[element] = currentCount - 1
        } else {
            storage.removeValue(forKey: element)
        }
        
        count -= 1
    }
    
    public var allItems: [Element] {
        var arr = [Element]()
        for (key, count) in storage {
            for _ in 0 ..< count {
                arr.append(key)
            }
        }
        
        return arr
    }
    
    public func count(for key: Element) -> UInt {
        return storage[key] ?? 0
    }
    
    public func isSubset(of superset: Multiset<Element>) -> Bool {
        for (key, count) in storage {
            let supersetCount = superset.storage[key] ?? 0
            if count > supersetCount {
                return false
            }
        }
        
        return true
    }
}

// MARK: - Equatable
extension Multiset: Equatable {
    public static func == (lhs: Multiset<Element>, rhs: Multiset<Element>) -> Bool {
        guard lhs.count == rhs.count else {
            return false
        }
        
        for (lhsKey, lhsCount) in lhs.storage {
            let rhsCount = rhs.storage[lhsKey] ?? 0
            if lhsCount != rhsCount {
                return false
            }
        }
        
        return true
    }
}

extension Multiset: ExpressibleByArrayLiteral {
    public init(arrayLiteral elements: Element...) {
        self.init(elements)
    }
}
