///|
pub fn planar_graph_neighbors(g : PlanarGraph, v : Int) -> Array[Int] {
  @planar_graph.PlanarGraph::neighbors(g, v)
}

///|
pub fn planar_graph_is_connected(g : PlanarGraph) -> Bool {
  @planar_graph.PlanarGraph::is_connected(g)
}

///|
pub fn planar_graph_face_count(g : PlanarGraph) -> Int {
  @planar_graph.PlanarGraph::face_count(g)
}

///|
pub fn planar_graph_from_polygon(g : PlanarGraph, poly : Polygon) -> PlanarGraph {
  @planar_graph.PlanarGraph::from_polygon(g, poly)
}

// ---------------------------------------------------------------------------
// face_extract: face extraction / 面提取
// ---------------------------------------------------------------------------

///|
pub type ExtractFace = @face_extract.Face

///|
pub fn extract_faces(verts : Array[Point2D], edges : Array[(Int, Int)]) -> Array[ExtractFace] {
  @face_extract.extract_faces(verts, edges)
}

///|
pub fn face_area(f : ExtractFace) -> Double {
  @face_extract.face_area(f)
}