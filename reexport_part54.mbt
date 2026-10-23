///|
/// Check if two curves intersect. / 检查两曲线相交。
pub fn curves_intersect(c1 : Array[Point2D], c2 : Array[Point2D]) -> Bool {
  @curve_intersect.curves_intersect(c1, c2)
}

// ---------------------------------------------------------------------------
// polyline: polyline operations / 折线操作
// ---------------------------------------------------------------------------


///|
/// Polyline length. / 折线长度。
pub fn polyline_length(pts : Array[Point2D]) -> Double {
  @polyline.polyline_length(pts)
}


///|
/// Simplify polyline (Douglas-Peucker). / 简化折线。
pub fn polyline_simplify(pts : Array[Point2D], eps : Double) -> Array[Point2D] {
  @polyline.polyline_simplify(pts, eps)
}


///|
/// Subdivide polyline segment. / 细分折线段。
pub fn polyline_subdivide(pts : Array[Point2D], idx : Int, t : Double) -> Array[Point2D] {
  @polyline.polyline_subdivide(pts, idx, t)
}


///|
/// Polyline segment count. / 折线段数。
pub fn polyline_segment_count(pts : Array[Point2D]) -> Int {
  @polyline.polyline_segment_count(pts)
}

// ---------------------------------------------------------------------------
// arc_length: arc length utilities / 弧长工具
// ---------------------------------------------------------------------------


///|
/// Single segment arc length. / 单线段弧长。
pub fn arc_length_segment(p1 : Point2D, p2 : Point2D) -> Double {
  @arc_length.arc_length_segment(p1, p2)
}
