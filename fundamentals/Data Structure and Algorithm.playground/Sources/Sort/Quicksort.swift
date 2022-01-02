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

    @discardableResult
    public mutating func quicksort(_ leftIndex: Int, _ rightIndex: Int) -> [T]? {
        // base case
        guard rightIndex - leftIndex > 0 else {
            return nil
        }

        // Partition the array and grab the position of the pivot
        let pivotPosition = partition(leftIndex, rightIndex)

        // Recursively call this quicksort method on whatever is to the left of the pivot
        quicksort(leftIndex, pivotPosition - 1)

        // Recursively call this quicksort method on whatever is to the right of the pivot
        quicksort(pivotPosition + 1, rightIndex)

        return array
    }

    // Selects the kth lowest element in the array
    @discardableResult
    public mutating func quickSelect(kthLowestValue: Int, leftIndex: Int, rightIndex: Int) -> T {
        guard rightIndex - leftIndex > 0 else {
            return array[leftIndex]
        }

        let pivotPosition = partition(leftIndex, rightIndex)

        if kthLowestValue < pivotPosition {
            quickSelect(kthLowestValue: kthLowestValue, leftIndex: leftIndex, rightIndex: pivotPosition - 1)
        } else if kthLowestValue > pivotPosition {
            quickSelect(kthLowestValue: kthLowestValue, leftIndex: pivotPosition + 1, rightIndex: rightIndex)
        }

        return array[pivotPosition]
    }
}

/*
 Easy to understand but not very efficient.
*/

public func quicksort<T: Comparable>(_ a: [T]) -> [T] {
    guard a.count > 1 else { return a }

    let pivot = a[a.count/2]
    let less = a.filter { $0 < pivot }
    let equal = a.filter { $0 == pivot }
    let greater = a.filter { $0 > pivot }

    return quicksort(less) + equal + quicksort(greater)
}

// MARK: - Lomuto
/*
 Lomuto's partitioning algorithm.
 This is conceptually simpler than Hoare's original scheme but less efficient.
 The return value is the index of the pivot element in the new array. The left
 partition is [low...p-1]; the right partition is [p+1...high], where p is the
 return value.
 The left partition includes all values smaller than or equal to the pivot, so
 if the pivot value occurs more than once, its duplicates will be found in the
 left partition.
 */
@discardableResult
public func partitionLomuto<T: Comparable>(_ a: inout [T], low: Int, high: Int) -> Int {
    // We always use the highest item as the pivot.
    let pivot = a[high]

    // This loop partitions the array into four (possibly empty) regions:
    //   [low  ...      i] contains all values <= pivot,
    //   [i+1  ...    j-1] contains all values > pivot,
    //   [j    ... high-1] are values we haven't looked at yet,
    //   [high           ] is the pivot value.
    var i = low
    for j in low..<high {
        if a[j] <= pivot {
            (a[i], a[j]) = (a[j], a[i])
            i += 1
        }
    }

    // Swap the pivot element with the first element that is greater than
    // the pivot. Now the pivot sits between the <= and > regions and the
    // array is properly partitioned.
    (a[i], a[high]) = (a[high], a[i])
    return i
}

/*
 Recursive, in-place version that uses Lomuto's partioning scheme.
 */
public func quicksortLomuto<T: Comparable>(_ a: inout [T], low: Int, high: Int) {
    if low < high {
        let p = partitionLomuto(&a, low: low, high: high)
        // The middle part p is left out because that place is exactly where it's supposed to be. No need to be rearranged
        quicksortLomuto(&a, low: low, high: p - 1)
        quicksortLomuto(&a, low: p + 1, high: high)
    }
}

/*
 Uses a random pivot index. On average, this results in a well-balanced split
 of the input array.
 */
public func quicksortRandom<T: Comparable>(_ a: inout [T], low: Int, high: Int) {
    if low < high {
        // Create a random pivot index in the range [low...high].
        let pivotIndex = random(min: low, max: high)

        // Because the Lomuto scheme expects a[high] to be the pivot entry, swap
        // a[pivotIndex] with a[high] to put the pivot element at the end.
        (a[pivotIndex], a[high]) = (a[high], a[pivotIndex])

        let p = partitionLomuto(&a, low: low, high: high)
        quicksortRandom(&a, low: low, high: p - 1)
        quicksortRandom(&a, low: p + 1, high: high)
    }
}

/* Returns a random integer in the range min...max, inclusive. */
private func random(min: Int, max: Int) -> Int {
    assert(min < max)
    return min + Int(arc4random_uniform(UInt32(max - min + 1)))
}

@discardableResult
func partitionHoare<T: Comparable>(_ a: inout [T], low: Int, high: Int) -> Int {
    let pivot = a[low]
    var i = low - 1
    var j = high + 1

    while true {
        repeat {
            // move the pointer from right to left until an element that's smaller than the pivot is encountered
            j -= 1
        } while a[j] > pivot

        repeat {
            // move the pointer from left to right until an element that's greater than the pivot is encountered
            i += 1
        } while a[i] < pivot

        if i < j {
            a.swapAt(i, j)
        } else {
            return j
        }
    }
}


/*
 Recursive, in-place version that uses Hoare's partioning scheme. Because of
 the choice of pivot, this performs badly if the array is already sorted.
 */
public func quicksortHoare<T: Comparable>(_ a: inout [T], low: Int, high: Int) {
    if low < high {
        let p = partitionHoare(&a, low: low, high: high)
        quicksortHoare(&a, low: low, high: p)
        quicksortHoare(&a, low: p + 1, high: high)
    }
}
