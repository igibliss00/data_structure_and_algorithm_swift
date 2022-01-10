import Foundation

//public func depthFirstSearch<T: Equatable>(_ graph: AdjacencyListGraph<T>, source: EdgeList<T>) -> [String] {
//    source.vertex.isVisited = true
//    var visitedNodes = [source.vertex.description]
//
//    guard let edges = source.edges else {
//        return []
//    }
//
//    print("source.vertex.index", source.vertex.index)
//
//    for edge in edges {
//        let neighbour = edge.to
//        if neighbour.isVisited == false {
//            let newEdgeList = graph.adjacencyList[neighbour.index]
//            visitedNodes += depthFirstSearch(graph, source: newEdgeList)
//        }
//    }
//
//    return visitedNodes
//}

public struct DFSEdge<T> {
    typealias N = DFSNode<T>
    var from: N
    var to: N
    var weight: Double?
}

extension DFSEdge: Equatable where T: Equatable {
    static public func == (lhs: DFSEdge, rhs: DFSEdge) -> Bool {
        return lhs.from == rhs.from &&
        lhs.to == rhs.to &&
        lhs.weight == rhs.weight
    }
}

public class DFSNode<T> {
    var value: T
    var edges: [DFSEdge<T>]?
    var isVisited = false
    
    public init(value: T, edges: [DFSEdge<T>]?) {
        self.value = value
        self.edges = edges
    }
}

extension DFSNode: CustomStringConvertible {
    public var description: String {
        return "\(value)"
    }
    
    public func addEdge(_ edge: DFSEdge<T>) {
        if edges == nil {
            edges = [edge]
        } else {
            edges?.append(edge)
        }
        
    }
}

extension DFSNode: Equatable where T: Equatable {
    static public func == (lhs: DFSNode<T>, rhs: DFSNode<T>) -> Bool {
        return lhs.value == rhs.value && lhs.edges == rhs.edges
    }
}

public class DFSGraph<T> where T: Equatable {
    public typealias N = DFSNode<T>
    public typealias E = DFSEdge<T>
    public private(set) var nodes: [N]
    
    public init() {
        nodes = []
    }
    
    public func addNode(_ value: T) -> N {
        let node = N(value: value, edges: nil)
        nodes.append(node)
        return node
    }
    
    public func addDirectedEdge(_ from: N, to: N, withWeight weight: Double?)  {
        guard let fromNode = nodes.filter({ $0.value == from.value }).first else {
            return
        }
        
        let edge = E(from: from, to: to, weight: weight)
        fromNode.addEdge(edge)
    }
    
    public func addUndirectedEdge(_ vertices: (N, N), weight: Double?) {
        addDirectedEdge(vertices.0, to: vertices.1, withWeight: weight)
        addDirectedEdge(vertices.1, to: vertices.0, withWeight: weight)
    }
}

//public func depthFirstSearch<T>(source: DFSNode<T>) -> [String] {
//    print("source", source)
//    source.isVisited = true
//    var visitedNodes = [source.description]
//
//    guard let edges = source.edges else {
//        return []
//    }
//
//    for edge in edges {
//        let neighbour = edge.to
//        if !neighbour.isVisited {
//            visitedNodes += depthFirstSearch(source: neighbour)
//        }
//    }
//
//    return visitedNodes
//}

public func depthFirstSearch<T: Equatable>(_ source: DFSNode<T>) -> [String] {
    var nodesExplored = [source.description]
    source.isVisited = true
    
    guard let edges = source.edges else {
        return []
    }
    
    for edge in edges {
        if !edge.to.isVisited {
            nodesExplored += depthFirstSearch(edge.to)
        }
    }
    return nodesExplored
}
