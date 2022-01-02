import Foundation

public struct HashedHeap<T: Hashable> where T: Comparable {
    fileprivate var elements = [T]()
    fileprivate var indices = [T: Int]()
    fileprivate var orderCriteria: (T, T) -> Bool
    
    public init(_ sort: @escaping (T, T) -> Bool) {
        self.orderCriteria = sort
    }
    
    public init(_ elements: [T], sort: @escaping (T, T) -> Bool) {
        self.elements = elements
        for i in elements.indices {
            indices.updateValue(i, forKey: elements[i])
        }
        
        self.orderCriteria = sort
    }
    
    public var isEmpty: Bool {
        return elements.isEmpty
    }
    
    public var count: Int {
        return elements.count
    }
    
    public func peek() -> T? {
        return elements.first
    }
    
    func parentIndex(_ index: Int) -> Int {
        return (index - 1) / 2
    }
    
    func leftChildIndex(_ index: Int) -> Int {
        return 2 * index + 1
    }
    
    func rightChildIndex(_ index: Int) -> Int {
        return 2 * index + 2
    }
    
    mutating func insert(_ value: T, at index: Int) {
        
    }
    
    mutating func shiftUp(index: Int) {
        var childIndex = index
        let childNode = elements[childIndex]
        var parentIndex = self.parentIndex(childIndex)

        while childIndex > 0 && orderCriteria(childNode, elements[parentIndex]) {
            set(elements[parentIndex], at: childIndex)
            childIndex = parentIndex
            parentIndex = self.parentIndex(childIndex)
        }
        
        set(childNode, at: childIndex)
    }
    
    internal mutating func shiftDown(from index: Int, until endIndex: Int) {
        let leftChildIndex = self.leftChildIndex(index)
        let rightChildIndex = leftChildIndex + 1
        
        var first = index
        if leftChildIndex < endIndex && orderCriteria(elements[leftChildIndex], elements[first]) {
            first = leftChildIndex
        }
        
        if rightChildIndex < endIndex && orderCriteria(elements[rightChildIndex], elements[first]) {
            first = rightChildIndex
        }
        
        if index == first { return }
        
        elements.swapAt(index, first)
        shiftDown(from: first, until: endIndex)
    }
    
    internal mutating func shiftDown(_ index: Int) {
        shiftDown(from: index, until: count)
    }
        
    private mutating func set(_ newValue: T, at index: Int) {
        indices[elements[index]] = nil
        elements[index] = newValue
        indices[newValue] = index
    }
}
