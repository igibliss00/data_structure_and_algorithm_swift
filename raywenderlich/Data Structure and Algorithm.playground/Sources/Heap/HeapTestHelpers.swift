import Foundation
import XCTest

public func checkHeap(_ heapFunction: Heap<Int>.Type, orderCriteria: String) {
//    let randomArray = randomArray(Int(arc4random_uniform(100)) + 1)
//    var heap = heapFunction.init(array: randomArray, sort: <)
//    checkOperations(&heap, with: 50)
//
//    guard let peak = heap.peek() else { return }
//    let min = randomArray.min()
//    XCTAssertEqual(peak, min)
    
    
    let numOfIterations = 100
    for _ in 1...numOfIterations {
        let randomArray = randomArray(Int(arc4random_uniform(100)) + 1)

        switch orderCriteria {
            case "<":
                let heap = heapFunction.init(array: randomArray, sort: <)
                
                guard let peak = heap.peek() else { return }
                let min = randomArray.min()
                XCTAssertEqual(peak, min)
                break
            case ">":
                let heap = heapFunction.init(array: randomArray, sort: >)
                guard let peak = heap.peek() else { return }
                let max = randomArray.max()
                XCTAssertEqual(peak, max)
                break
            default:
                break
        }
    }
}

func checkOperations(_ heap: inout Heap<Int>, with value: Int) {
    heap.insert(value)
}

//func checkMinMaxRandomArray(_ heapFunction: @escaping ([Int], (Int, Int) -> Bool) -> [Int]) {
//    checkMinMaxRandomArray { a in heapFunction(a, <) }
//}

