///|
/// Spline total length. / 样条总长度。
pub fn spline_length(pts : Array[Point2D]) -> Double {
  @spline.spline_length(pts)
}


///|
/// Spline curvature at point i. / 样条在点 i 处曲率。
pub fn spline_curvature(pts : Array[Point2D], i : Int) -> Double {
  @spline.spline_curvature(pts, i)
}


///|
/// Spline curvature profile. / 样条曲率分布。
pub fn spline_curvature_profile(pts : Array[Point2D]) -> Array[Double] {
  @spline.spline_curvature_profile(pts)
}


///|
/// Spline total curvature. / 样条总曲率。
pub fn spline_total_curvature(pts : Array[Point2D]) -> Double {
  @spline.spline_total_curvature(pts)
}


///|
/// Max curvature point. / 最大曲率点。
pub fn spline_max_curvature_point(pts : Array[Point2D]) -> Int? {
  @spline.spline_max_curvature_point(pts)
}

// ---------------------------------------------------------------------------
// curve_arc: arc length / 弧长
// ---------------------------------------------------------------------------


///|
/// Total arc length. / 总弧长。
pub fn arc_length(pts : Array[Point2D]) -> Double {
  @curve_arc.arc_length(pts)
}


///|
/// Arc length at parameter t. / 参数 t 处弧长。
pub fn arc_length_at(pts : Array[Point2D], t : Double) -> Double {
  @curve_arc.arc_length_at(pts, t)
}
