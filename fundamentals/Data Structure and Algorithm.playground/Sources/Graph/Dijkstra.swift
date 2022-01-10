import Foundation

open class DVertex {
    open var identifier: String
    open var neighbours: [(DVertex, Double)] = []
    open var pathLengthFromStart = Double.infinity
    open var pathVerticesFromStart: [DVertex] = []
    
    public init(identifier: String) {
        self.identifier = identifier
    }
    
    open func clearCache() {
        pathLengthFromStart = Double.infinity
        pathVerticesFromStart = []
    }
}

extension DVertex: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
}

extension DVertex: Equatable {
    static public func == (lhs: DVertex, rhs: DVertex) -> Bool {
        lhs.hashValue == rhs.hashValue
    }
}

public class Dijkstra {
    private var totalVertices: Set<DVertex>
    
    public init(vertices: Set<DVertex>) {
        totalVertices = vertices
    }
    
    private func clearCache() {
        totalVertices.forEach { $0.clearCache() }
    }
    
    public func findShortestPaths(from startVertex: DVertex) {
        clearCache()
        
        var currentVertex = startVertex
        
        while let vertex = currentVertex {
            
        }
    }
}
