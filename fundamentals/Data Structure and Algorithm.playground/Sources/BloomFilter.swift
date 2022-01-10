import Foundation

public class BloomFilter<T: Hashable> {
    fileprivate var array: [Bool]
    fileprivate var hashFunctions: [(T) -> Int]
    
    public init(size: Int = 1024, hashFunctions: [(T) -> Int]) {
        self.array = Array(repeating: false, count: size)
        self.hashFunctions = hashFunctions
    }
    
    private func computeHashes(_ value: T) -> [Int] {
        return hashFunctions.map { hashFunc in
            abs(hashFunc(value) % array.count)
        }
    }
    
    public func insert(_ value: T) {
        let hash = computeHashes(value)
        hash.forEach { array[$0] = true }
    }
    
    public func insert(_ values: [T]) {
        values.forEach { insert($0) }
    }
    
    public func contains(_ value: T) -> Bool {
        let hashValues = computeHashes(value)
        let results = hashValues.map { array[$0] }
        return results.reduce (true, { $0 && $1 })
    }
}
