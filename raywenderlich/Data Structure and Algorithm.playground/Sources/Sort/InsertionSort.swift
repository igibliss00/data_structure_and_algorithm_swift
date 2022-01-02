import Foundation

public struct InsertSort<T> where T: Comparable {
    public init() { }
    public func insertionSort<T>(_ data: [T]) -> [T] where T: Comparable {
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
    
    public func sort<T>(_ array: [T], _ isOrderedBefore: (T, T) -> Bool) -> [T] {
        guard array.count > 1 else { return array }
        ///   - sortedArray: copy the array to save stability
        var sortedArray = array
        for index in 1..<sortedArray.count {
            var currentIndex = index
            let temp = sortedArray[currentIndex]
            while currentIndex > 0, isOrderedBefore(temp, sortedArray[currentIndex - 1]) {
                sortedArray[currentIndex] = sortedArray[currentIndex - 1]
                currentIndex -= 1
            }
            sortedArray[currentIndex] = temp
        }
        return sortedArray
    }
    
    /// Performs the Insertion sort algorithm to a given array
    ///
    /// - Parameter array: the array to be sorted, containing elements that conform to the Comparable protocol
    /// - Returns: a sorted array containing the same elements
    public func sort<T: Comparable>(_ array: [T]) -> [T] {
        guard array.count > 1 else { return array }
        
        var sortedArray = array
        for index in 1..<sortedArray.count {
            var currentIndex = index
            let temp = sortedArray[currentIndex]
            while currentIndex > 0, temp < sortedArray[currentIndex - 1] {
                sortedArray[currentIndex] = sortedArray[currentIndex - 1]
                currentIndex -= 1
            }
            sortedArray[currentIndex] = temp
        }
        return sortedArray
    }
}   
