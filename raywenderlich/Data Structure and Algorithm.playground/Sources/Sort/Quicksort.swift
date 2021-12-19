import Foundation

public struct SortableArray<T: Comparable> {
    var array: [T] = []
    
    public init(_ array: [T]) {
        self.array = array
    }
    
    public mutating func partition(_ leftPointer: Int, _ rightPointer: Int) -> Int {
        let pivotPositon = rightPointer
        let pivot = array[rightPointer]
        var newLeftPointer = leftPointer
        var newRightPointer = rightPointer - 1
        
        while true {
            while array[newLeftPointer] < pivot {
                newLeftPointer += 1
            }
            
            while array[newRightPointer] > pivot {
                newRightPointer -= 1
            }
            
            if newLeftPointer >= newRightPointer {
                break
            } else {
                array.swapAt(newLeftPointer, newRightPointer)
            }
        }
        
        array.swapAt(newLeftPointer, pivotPositon)
        
        return newLeftPointer
    }
    
    public mutating func quicksort(_ leftIndex: Int, _ rightIndex: Int) -> [T]? {
        // base case
        guard rightIndex - leftIndex > 0 else {
            return nil
        }
        
        // Partition the array and grab the position of the pivot
        let pivotPosition = partition(leftIndex, rightIndex)
        
        // Recursively call this quicksort method on whatever is to the left of the pivot
        _ = quicksort(leftIndex, pivotPosition - 1)
        
        // Recursively call this quicksort method on whatever is to the right of the pivot
        _ = quicksort(pivotPosition + 1, rightIndex)
        
        return array
    }
    
    public mutating func quickSelect(kthLowestValue: Int, leftIndex: Int, rightIndex: Int) -> T {
        guard rightIndex - leftIndex > 0 else {
            return array[leftIndex]
        }
        
        let pivotPosition = partition(leftIndex, rightIndex)
        
        if kthLowestValue < pivotPosition {
            _ = quickSelect(kthLowestValue: kthLowestValue, leftIndex: leftIndex, rightIndex: pivotPosition - 1)
        } else if kthLowestValue > pivotPosition {
            _ = quickSelect(kthLowestValue: kthLowestValue, leftIndex: pivotPosition + 1, rightIndex: rightIndex)
        }
        
        return array[pivotPosition]
    }
}
