//import Foundation
//
//public class Edge<T>: Hashable where T: Hashable {
//    public typealias V = Vertex<T>
//    private(set) public var sourceVertex: V
//    private(set) public var destinationVertex: V
//    private(set) public var weight: Double?
//    
//    public init(from sourceVertex: V, to destinationVertex: V, weight: Double?) {
//        self.sourceVertex = sourceVertex
//        self.destinationVertex = destinationVertex
//        self.weight = weight
//    }
//}
//
//extension Edge {
//    static public func == (lhs: Edge<T>, rhs: Edge<T>) -> Bool {
//        return lhs.sourceVertex == rhs.sourceVertex &&
//        lhs.destinationVertex == rhs.destinationVertex &&
//        lhs.weight == rhs.weight
//    }
//    
//    public func hash(into hasher: inout Hasher) {
//        hasher.combine(sourceVertex)
//        hasher.combine(destinationVertex)
//        hasher.combine(weight)
//    }
//}
//
//public class Vertex<T>: Hashable where T: Hashable {
//    public var data: T
//    public var index: Int
//    public var visited: Bool = false
//    
//    public init(data: T, index: Int) {
//        self.data = data
//        self.index = index
//    }
//}
//
//extension Vertex {
//    static public func == (lhs: Vertex<T>, rhs: Vertex<T>) -> Bool {
//        return lhs.data == rhs.data
//    }
//    
//    public func hash(into hasher: inout Hasher) {
//        hasher.combine(data)
//    }
//}
//
//extension Vertex: CustomStringConvertible {
//    public var description: String {
//        return "\(data)"
//    }
//}
//
//public class EdgeList<T> where T: Hashable {
//    var vertex: Vertex<T>
//    var edges: Set<Edge<T>>?
//
//    public init(vertex: Vertex<T>, edges: Set<Edge<T>>? = nil) {
//        self.vertex = vertex
//        self.edges = edges
//    }
//}
//
//extension EdgeList {
//    public func addEdge(_ from: Vertex<T>, to: Vertex<T>, weight: Double?) {
//        let edge = Edge(from: from, to: to, weight: weight)
//        
//        addEdge(edge)
//    }
//    
//    public func addEdge(_ edge: Edge<T>) {
//        if edges == nil {
//            edges = [edge]
//        } else {
//            edges?.insert(edge)
//        }
//    }
//}
//
//extension EdgeList: CustomStringConvertible {
//    public var description: String {
//        return "\(vertex)" + " " + "\(edges.map { "\($0)"} ?? "No edges")"
//    }
//}
//
//open class AbstractGraph<T> where T: Hashable {
//    
//    required public init() { }
//    required public init(fromGraph graph: AbstractGraph<T>) {
//        for edge in graph.edges {
//            let from = createVertex(edge.sourceVertex.data)
//            let to = createVertex(edge.destinationVertex.data)
//            addDirectionalEdge(from, to: to, withWeight: edge.weight)
//        }
//    }
//    
//    open var vertices: [Vertex<T>] {
//        fatalError()
//    }
//    
//    open var edges: [Edge<T>] {
//        fatalError()
//    }
//    
//    open func createVertex(_ data: T) -> Vertex<T> {
//        fatalError()
//
//    }
//    
//    open func addDirectionalEdge(_ sourceVertex: Vertex<T>, to destinationVertex: Vertex<T>, withWeight weight: Double?) {
//        fatalError()
//    }
//    
//    open func addUndirectionalEdge(_ vertices: (Vertex<T>, Vertex<T>), withWeight weight: Double?) {
//        fatalError()
//
//    }
//    
//    open func edgesFrom(_ vertex: Vertex<T>) -> [Edge<T>] {
//        fatalError()
//
//    }
//    
//    open func weightFrom(_ sourceVertex: Vertex<T>, to destinationVertex: Vertex<T>) -> Double? {
//        fatalError()
//
//    }
//}
//
//open class AdjacencyList<T>: AbstractGraph<T> where T: Hashable {
//    public typealias V = Vertex<T>
//    public typealias E = Edge<T>
//    
//    fileprivate var adjacencyLists = [EdgeList<T>]()
//    
//    required public init() {
//        super.init()
//    }
//    
//    required public init(fromGraph graph: AbstractGraph<T>) {
//        super.init(fromGraph: graph)
//    }
//    
//    open override var vertices: [V] {
//        var vertices = [V]()
//        for edgeList in adjacencyLists {
//            vertices.append(edgeList.vertex)
//        }
//        
//        return vertices
//    }
//    
//    open override var edges: [E] {
//        var allEdgeList = [E]()
//        for edgeList in adjacencyLists {
//            guard let edges = edgeList.edges else {
//                continue
//            }
//            
//            for edge in edges {
//                allEdgeList.append(edge)
//            }
//        }
//        
//        return allEdgeList
//    }
//    
//    open override func createVertex(_ data: T) -> Vertex<T> {
//        let existingVertices = vertices.filter { $0.data == data }
//        if existingVertices.count > 0 {
//            return existingVertices.first!
//        }
//        
//        let vertex = V(data: data, index: adjacencyLists.count)
//        let edgeList = EdgeList(vertex: vertex, edges: nil)
//        adjacencyLists.append(edgeList)
//        return vertex
//    }
//    
//    open override func addDirectionalEdge(_ sourceVertex: Vertex<T>, to destinationVertex: Vertex<T>, withWeight weight: Double?) {
//        let edge = E(from: sourceVertex, to: destinationVertex, weight: weight)
//        for case let edgeList in adjacencyLists where edgeList.vertex == sourceVertex {
//            if edgeList.edges != nil {
//                edgeList.addEdge(edge)
//            } else {
//                edgeList.edges = [edge]
//            }
//        }
//    }
//    
//    open override func addUndirectionalEdge(_ vertices: (Vertex<T>, Vertex<T>), withWeight weight: Double?) {
//        addDirectionalEdge(vertices.0, to: vertices.1, withWeight: weight)
//        addDirectionalEdge(vertices.1, to: vertices.0, withWeight: weight)
//    }
//    
//    open override func edgesFrom(_ vertex: Vertex<T>) -> [Edge<T>] {
//        return Array(adjacencyLists[vertex.index].edges ?? [])
//    }
//    
//    open override func weightFrom(_ sourceVertex: Vertex<T>, to destinationVertex: Vertex<T>) -> Double? {
//        for case let edge in edges where edge.sourceVertex == sourceVertex && edge.destinationVertex == destinationVertex {
//            return edge.weight
//        }
//        
//        return nil
//    }
//}
//
//func breathFirstSearch<T>(graph: AdjacencyList<T>) -> [String] {
//    guard let source = graph.adjacencyLists.first else {
//        return []
//    }
//    
//    var visitedNodes = [EdgeList<T>]()
//    visitedNodes.append(source)
//    
//    var queue = Queue<EdgeList<T>>()
//    queue.enqueue(source)
//    
//    while let current = queue.dequeue() {
//        guard let edges = current.edges else {
//            continue
//        }
//        
//        for edge in edges {
//            if !edge.destinationVertex.visited {
//                
//            }
//        }
//    }
//}
