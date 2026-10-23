///|
/// Get the number of vertices in the overlay. / 获取叠加结果中的顶点数。
pub fn overlay_vertex_count(result : OverlayResult) -> Int32 {
  result.vertices.length()
}

///|
/// Get the number of edges in the overlay. / 获取叠加结果中的边数。
pub fn overlay_edge_count(result : OverlayResult) -> Int32 {
  result.edges.length()
}

///|
/// Get all vertices of the overlay. / 获取叠加结果的所有顶点。
pub fn overlay_vertices(result : OverlayResult) -> Array[@core.Point2D] {
  result.vertices
}

///|
/// Get all edges of the overlay. / 获取叠加结果的所有边。
pub fn overlay_edges(result : OverlayResult) -> Array[(Int32, Int32)] {
  result.edges
}
