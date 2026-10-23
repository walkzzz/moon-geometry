///|
pub fn build_arrangement(segs : Array[Segment]) -> Arrangement {
  @arrangement.build_arrangement(segs)
}

///|
pub fn arrangement_vertices(arr : Arrangement) -> Array[ArrangementVertex] {
  @arrangement.arrangement_vertices(arr)
}

///|
pub fn arrangement_intersection_count(arr : Arrangement) -> Int {
  @arrangement.arrangement_intersection_count(arr)
}

///|
pub fn arrangement_edge_count(arr : Arrangement) -> Int {
  @arrangement.arrangement_edge_count(arr)
}

///|
pub fn arrangement_face_count(arr : Arrangement) -> Int {
  @arrangement.arrangement_face_count(arr)
}

// ---------------------------------------------------------------------------
// planar_graph: planar graph / 平面图
// ---------------------------------------------------------------------------

///|
pub type PlanarEdge = @planar_graph.PlanarEdge

///|
pub type PlanarGraph = @planar_graph.PlanarGraph