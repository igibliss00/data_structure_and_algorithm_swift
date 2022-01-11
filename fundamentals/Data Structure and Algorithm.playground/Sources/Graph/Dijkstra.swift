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
        var currentVertices = self.totalVertices
        startVertex.pathLengthFromStart = 0
        startVertex.pathVerticesFromStart.append(startVertex)
        var currentVertex: DVertex? = startVertex
        while let vertex = currentVertex {
            currentVertices.remove(vertex)
            let filteredNeighbors = vertex.neighbours.filter { currentVertices.contains($0.0) }
            for neighbor in filteredNeighbors {
                let neighborVertex = neighbor.0
                let weight = neighbor.1
                
                let theoreticNewWeight = vertex.pathLengthFromStart + weight
                print("theoreticNewWeight", theoreticNewWeight)
                print("neighborVertex.pathLengthFromStart", neighborVertex.pathLengthFromStart)
                if theoreticNewWeight < neighborVertex.pathLengthFromStart {
                    neighborVertex.pathLengthFromStart = theoreticNewWeight
                    neighborVertex.pathVerticesFromStart = vertex.pathVerticesFromStart
                    neighborVertex.pathVerticesFromStart.append(neighborVertex)
                }
            }
            if currentVertices.isEmpty {
                currentVertex = nil
                break
            }
            currentVertex = currentVertices.min { $0.pathLengthFromStart < $1.pathLengthFromStart }
        }
    }
}
