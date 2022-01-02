import Foundation

// MARK: - Data Structure and Algorithms book example for graph
public final class Person {
    var name: String
    var friends: [Person] = []
    var visited: Bool = false
    var toReset: [Person] = []
    var queue = Queue<Person>()
    
    public init(name: String) {
        self.name = name
    }
    
    public func addFriend(_ friend: Person) {
        self.friends.append(friend)
    }
    
    public func displayNetwork() {
        toReset.append(self)
        queue.enqueue(self)
        
        while !queue.isEmpty {
            let currentVertex = queue.dequeue()
            
            currentVertex?.friends.forEach({ friend in
                if !friend.visited {
                    print("!",friend.name)
                    toReset.append(friend)
                    queue.enqueue(friend)
                    friend.visited = true
                }
            })
        }
        
        toReset.forEach { $0.visited = false }
    }
}
