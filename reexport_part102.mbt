///|
pub fn loose_octree_query(node : LooseOctNode, min_x : Double, min_y : Double, min_z : Double, max_x : Double, max_y : Double, max_z : Double) -> Array[Point3D] {
  @loose_octree.loose_octree_query(node, min_x, min_y, min_z, max_x, max_y, max_z)
}

///|
pub fn loose_octree_count(node : LooseOctNode) -> Int {
  @loose_octree.loose_octree_count(node)
}
// ---------------------------------------------------------------------------
// shortest_path: Dijkstra shortest path / Dijkstra 最短路径
// ---------------------------------------------------------------------------

///|
pub type GraphEdge = @shortest_path.GraphEdge

///|
pub fn dijkstra(n : Int, adj : Array[Array[GraphEdge]], src : Int) -> Array[Double] {
  @shortest_path.dijkstra(n, adj, src)
}

///|
pub fn shortest_path_dist(n : Int, adj : Array[Array[GraphEdge]], src : Int, dst : Int) -> Double {
  @shortest_path.shortest_path_dist(n, adj, src, dst)
}

///|
pub fn shortest_path_vertices(n : Int, adj : Array[Array[GraphEdge]], src : Int, dst : Int) -> Array[Int] {
  @shortest_path.shortest_path_vertices(n, adj, src, dst)
}

// ---------------------------------------------------------------------------
// visibility_graph: Visibility graph / 可见性图
// ---------------------------------------------------------------------------

///|
pub fn build_visibility_graph(obstacles : Array[Array[Point2D]], start : Point2D, goal : Point2D) -> Array[Array[(Int, Double)]] {
  @visibility_graph.build_visibility_graph(obstacles, start, goal)
}