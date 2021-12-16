import Foundation

public struct SelectionSort<T> where T: Comparable {
    public init () { }
    
    public func sort<T>(_ data: [T], _ isOrderedBefore: (T, T) -> Bool) -> [T] where T: Comparable {
        guard data.count > 1 else { return data }
        var a = data
        for x in 0..<a.count - 1 {
            var lowest = x
            for y in x + 1..<a.count {
                if isOrderedBefore(a[y], a[lowest]) {
                    lowest = y
                }
            }
            
            if lowest != x {
                a.swapAt(x, lowest)
            }
        }
        
        return a
    }
}
