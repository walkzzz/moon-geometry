///|
/// Build a planar graph from a polygon's edges. / 由多边形的边构建平面图。
pub fn PlanarGraph::from_polygon(
  graph : PlanarGraph,
  poly : @core.Polygon,
) -> PlanarGraph {
  let n = poly.size()
  if n < 3 {
    return graph
  }
  let indices : Array[Int32] = []
  for i in 0..<n {
    indices.push(graph.add_vertex(poly.get(i)))
  }
  for i in 0..<n {
    graph.add_edge(indices[i], indices[(i + 1) % n])
  }
  graph
}
