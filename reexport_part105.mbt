///|
pub fn chromatic_number_upper(n : Int, adj : Array[Array[Int]]) -> Int {
  @graph_color.chromatic_number_upper(n, adj)
}

///|
pub fn is_valid_coloring(n : Int, adj : Array[Array[Int]], colors : Array[Int]) -> Bool {
  @graph_color.is_valid_coloring(n, adj, colors)
}

///|
pub fn is_bipartite(n : Int, adj : Array[Array[Int]]) -> Bool {
  @graph_color.is_bipartite(n, adj)
}

// ---------------------------------------------------------------------------
// graph_cut: Graph cut / 图割
// ---------------------------------------------------------------------------

///|
pub fn max_flow(n : Int, capacity : Array[Array[Double]], src : Int, sink : Int) -> Double {
  @graph_cut.max_flow(n, capacity, src, sink)
}

///|
pub fn min_cut(n : Int, capacity : Array[Array[Double]], src : Int, sink : Int) -> Double {
  @graph_cut.min_cut(n, capacity, src, sink)
}

///|
pub fn min_cut_partition(n : Int, capacity : Array[Array[Double]], src : Int, sink : Int) -> Array[Int] {
  @graph_cut.min_cut_partition(n, capacity, src, sink)
}

// ---------------------------------------------------------------------------
// spanning_tree: Minimum spanning tree / 最小生成树
// ---------------------------------------------------------------------------

///|
pub type WEdge = @spanning_tree.WEdge