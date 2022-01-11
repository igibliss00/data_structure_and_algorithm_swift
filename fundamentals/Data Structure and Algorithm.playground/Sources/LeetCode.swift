import Foundation

public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init() { self.val = 0; self.next = nil; }
    public init(_ val: Int) { self.val = val; self.next = nil; }
    public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
}

public class Solution2 {
    public init() { }
    
    public func createNodes(_ vals: [Int], isReversed: Bool = false) -> [ListNode] {
        var currentNode: ListNode?
        var nodes = [ListNode]()
        
        for val in isReversed ? vals.reversed() : vals {
            let listNode = createNode(val, prevNode: currentNode)
            nodes.append(listNode)
            currentNode = listNode
        }
        
        return nodes
    }
    
    public func createNode(_ val: Int, prevNode: ListNode?) -> ListNode {
        let listNode = ListNode(val)
        prevNode?.next = listNode
        return listNode
    }
    
    public func getValues(_ head: ListNode?, isReversed: Bool = false) -> [String] {
        var vals = [String]()
        var node: ListNode? = head
        while let currentNode = node {
            if isReversed == true {
                vals.insert("\(currentNode.val)", at: 0)
            } else {
                vals.append("\(currentNode.val)")
            }
            
            node = currentNode.next
        }
        
        return vals
    }
    
    public func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        let firstList = getValues(l1)
        let secondList = getValues(l2)
        
        let s1 = firstList.joined()
        let s2 = secondList.joined()
        
        guard let a = Int(s1), let b = Int(s2) else {
            return nil
        }
        
        let sum =  a + b
        let converted = String(sum)
        var convertedIntArray = [Int]()
        for char in converted {
            guard let val = Int("\(char)") else {
                return nil
            }
            convertedIntArray.append(val)
        }
        
        let finalList = createNodes(convertedIntArray, isReversed: true)
        
        return finalList.first
    }
}

public class Solution3 {
    public init() { }
//    public func lengthOfLongestSubstring(_ s: String) -> Int {
//        var longest = 0
//        var current = 0
//
//        for i in 1 ..< s.count {
//            let firstIndex = s.index(s.startIndex, offsetBy: i - 1)
//            let secondIndex = s.index(s.startIndex, offsetBy: i)
//
//            if s[firstIndex] == s[secondIndex] {
//                if longest < current {
//                    longest = current
//                }
//            } else {
//                current += 1
//            }
//        }
//
//        return longest
//    }
    
    public func lengthOfLongestSubstring(_ s: String) -> Int {
        var totalCounts = [Int]()
        var currentCount = 0
        
        for i in 1 ..< s.count {
            var firstIndex = s.index(s.startIndex, offsetBy: i)
            var firstChar = s[firstIndex]
            for j in 0 ..< i {
                let secondIndex = s.index(s.startIndex, offsetBy: j)
                let secondChar = s[secondIndex]

                if firstChar != secondChar {
                    currentCount += 1
                } else {
                    totalCounts.append(currentCount)
                }
            }
        }
    }
}
