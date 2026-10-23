///|
pub fn face_count(faces : Array[ExtractFace]) -> Int {
  @face_extract.face_count(faces)
}

// ---------------------------------------------------------------------------
// overlay: planar subdivision overlay / 平面细分叠加
// ---------------------------------------------------------------------------

///|
pub type OverlayResult = @overlay.OverlayResult

///|
pub fn overlay(s1 : Array[Segment], s2 : Array[Segment]) -> OverlayResult {
  @overlay.overlay(s1, s2)
}

///|
pub fn overlay_vertex_count(r : OverlayResult) -> Int {
  @overlay.overlay_vertex_count(r)
}

///|
pub fn overlay_edge_count(r : OverlayResult) -> Int {
  @overlay.overlay_edge_count(r)
}

///|
pub fn overlay_vertices(r : OverlayResult) -> Array[Point2D] {
  @overlay.overlay_vertices(r)
}

///|
pub fn overlay_edges(r : OverlayResult) -> Array[(Int, Int)] {
  @overlay.overlay_edges(r)
}

// ---------------------------------------------------------------------------
// euler_tour: Euler tour / 欧拉回路
// ---------------------------------------------------------------------------