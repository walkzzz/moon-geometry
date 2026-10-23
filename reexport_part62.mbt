///|
pub fn dcel_vertex_count(d : DCEL) -> Int {
  @dcel.DCEL::vertex_count(d)
}

///|
pub fn dcel_edge_count(d : DCEL) -> Int {
  @dcel.DCEL::edge_count(d)
}

///|
pub fn dcel_face_count(d : DCEL) -> Int {
  @dcel.DCEL::face_count(d)
}

///|
pub fn dcel_trace_face(d : DCEL, start_he : Int) -> Array[Int] {
  @dcel.DCEL::trace_face(d, start_he)
}

///|
pub fn dcel_from_polygon(d : DCEL, poly : Polygon) -> DCEL {
  @dcel.DCEL::from_polygon(d, poly)
}

// ---------------------------------------------------------------------------
// arrangement: line segment arrangement / 线段排列
// ---------------------------------------------------------------------------

///|
pub type ArrangementVertex = @arrangement.ArrangementVertex

///|
pub type Arrangement = @arrangement.Arrangement