///|
/// Reparameterize by arc length. / 按弧长重参数化。
pub fn arc_length_parametrize(pts : Array[Point2D], num_samples : Int) -> Array[Point2D] {
  @curve_arc.arc_length_parametrize(pts, num_samples)
}


///|
/// Arc length to parameter. / 弧长转参数。
pub fn arc_length_to_param(pts : Array[Point2D], s : Double) -> Double {
  @curve_arc.arc_length_to_param(pts, s)
}

// ---------------------------------------------------------------------------
// curve_intersect: curve intersection / 曲线相交
// ---------------------------------------------------------------------------


///|
/// Check if two segments cross. / 检查两线段相交。
pub fn segments_cross(p1 : Point2D, p2 : Point2D, p3 : Point2D, p4 : Point2D) -> Bool {
  @curve_intersect.segments_cross(p1, p2, p3, p4)
}


///|
/// Check polyline self-intersection. / 检查折线自相交。
pub fn curve_self_intersect(pts : Array[Point2D]) -> Bool {
  @curve_intersect.curve_self_intersect(pts)
}


///|
/// Count self-intersections. / 自相交计数。
pub fn curve_self_intersect_count(pts : Array[Point2D]) -> Int {
  @curve_intersect.curve_self_intersect_count(pts)
}
