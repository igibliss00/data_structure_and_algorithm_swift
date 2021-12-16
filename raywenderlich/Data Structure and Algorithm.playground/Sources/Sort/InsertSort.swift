import Foundation

public struct InsertSort<T> where T: Comparable {
    public init() { }
    public func sort<T>(_ data: [T]) -> [T] where T: Comparable {
        guard data.count > 0 else { return data }
        
        var a = data
        for i in 0..<a.count - 1 {
            compare(i, i + 1, data: &a)
        }
        
        return a
    }
    
    private func compare<T>(_ first: Int, _ second: Int, data: inout [T]) where T: Comparable {
        guard first >= 0 else { return }
        if data[first] > data[second] {
            data.swapAt(first, second)
            compare(first - 1, first, data: &data)
        }
    }
    
    public func sort2<T>(_ data: [T], _ inOrderedBefore: (T, T) -> Bool) -> [T] where T: Comparable {
        guard data.count > 1 else { return data }
        
        var a = data
        for i in 0..<a.count {
            var index = i
            let temp = a[i]
            
            while index > 0 && inOrderedBefore(a[index - 1], temp) {
                a[index] = a[index - 1]
                index -= 1
            }
            
            a[index] = temp
        }
        
        return a
    }
}   
