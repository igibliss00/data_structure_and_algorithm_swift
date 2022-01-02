import Foundation

public struct BubbleSort<T> where T: Comparable {
    public init() {}

    public func sort(_ data: [T], _ comparison: (T, T) -> Bool) -> [T] {
        var array = data
        for i in 0..<array.count {
            for j in 1..<array.count - i {
                if comparison(array[j], array[j-1]) {
                    let temp = array[j-1]
                    array[j-1] = array[j]
                    array[j] = temp
                }
            }
        }

        return array
    }
    
    public func sort2(_ data: [T]) -> [T] {
        var array = data
        for i in 0..<array.count {
            for j in 1..<array.count - i {
                if array[j] < array[j-1] {
                    let tmp = array[j-1]
                    array[j-1] = array[j]
                    array[j] = tmp
                }
            }
        }
        return array
    }
}
