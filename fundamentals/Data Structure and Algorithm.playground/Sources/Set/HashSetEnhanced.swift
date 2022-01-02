import Foundation

/// Hashset using the custom HashTable
public struct HashSetEnhanced<T: Hashable> {
    private var dictionary: HashTable<T,Bool>
    
    public init(capacity: Int) {
        dictionary = HashTable<T,Bool>(capacity: capacity)
    }
    
    public mutating func insert(_ element: T) {
        dictionary[element] = true
    }
    
    public mutating func remove(_ element: T) {
        dictionary[element] = nil
    }
    
    public func contains(_ element: T) -> Bool {
        return dictionary[element] != nil
    }
    
    public func allElements() -> [T] {
        return Array(dictionary.keys)
    }
    
    public var count: Int {
        return dictionary.count
    }
    
    public var isEmpty: Bool {
        return dictionary.isEmpty
    }
}
