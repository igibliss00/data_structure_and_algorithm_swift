import Foundation

public class BFSEdge: Equatable {
    public var neighbor: BFSNode
    
    public init(_ neighbor: BFSNode) {
        self.neighbor = neighbor
    }
    
    static public func == (_ lhs: BFSEdge, rhs: BFSEdge) -> Bool {
        return lhs.neighbor == rhs.neighbor
    }
}

public class BFSNode: CustomStringConvertible, Equatable {
    public var neighbors: [BFSEdge]
    public private(set) var label: String
    public var distance: Int?
    public var visited: Bool
    
    public init(_ label: String) {
        self.label = label
        self.neighbors = []
        self.visited = false
    }
    
    public var description: String {
        if let distance = distance {
            return "Node(label: \(label), distance: \(distance)"
        }
        
        return "Node(label: \(label), distance: infinity)"
    }
    
    public var hasDistance: Bool {
        return distance != nil
    }
    
    public func remove(_ edge: BFSEdge) {
        neighbors.remove(at: neighbors.firstIndex { $0 == edge }!)
    }
    
    static public func == (_ lhs: BFSNode, rhs: BFSNode) -> Bool {
        return lhs.label == rhs.label && lhs.neighbors == rhs.neighbors
    }
}

public class BFSGraph: Equatable {
    public private(set) var nodes: [BFSNode]
    
    public init() {
        self.nodes = []
    }
    
    public var source: BFSNode {
        return nodes[Int(arc4random_uniform(UInt32(nodes.count - 1)))]
    }
    
    @discardableResult public func addNode(_ label: String) -> BFSNode {
        let node = BFSNode(label)
        nodes.append(node)
        return node
    }
    
    public func addEdge(_ source: BFSNode, neighbor: BFSNode) {
        let edge = BFSEdge(neighbor)
        source.neighbors.append(edge)
    }
    
    static public func == (lhs: BFSGraph, rhs: BFSGraph) -> Bool {
        return lhs.nodes == rhs.nodes
    }
}

public func breadthFirstSearch(_ graph: BFSGraph) -> [String] {
    let source = graph.source
    var queue = Queue<BFSNode>()
    queue.enqueue(source)
    
    var nodesExplored = [source.label]
    source.visited = true
    
    while let current = queue.dequeue() {
        for edge in current.neighbors {
            let neighborNode = edge.neighbor
            if !neighborNode.visited {
                queue.enqueue(neighborNode)
                neighborNode.visited = true
                nodesExplored.append(neighborNode.label)
            }
        }
    }
    
    return nodesExplored
}

public func breadthFirstSearch1<T>(_ graph: AdjacencyListGraph<T>) -> [String] {
    guard let source = graph.adjacencyList.first else {
        return []
    }
    
    var queue = Queue<EdgeList<T>>()
    queue.enqueue(source)
    source.vertex.isVisited = true
    var nodesExplored: [String] = [source.vertex.description]
    
    while let current = queue.dequeue() {
        guard let edges = current.edges else {
            continue
        }
        
        for edge in edges {
            var neighbourNode = edge.to
            if !neighbourNode.isVisited {
                let edgeList = graph.adjacencyList[neighbourNode.index]
                queue.enqueue(edgeList)
                neighbourNode.isVisited = true
                nodesExplored.append(neighbourNode.description)
            }
        }
    }
    
    return nodesExplored
}
