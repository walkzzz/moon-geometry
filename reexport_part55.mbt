///|
/// Total arc length. / 总弧长。
pub fn arc_length_total(pts : Array[Point2D]) -> Double {
  @arc_length.arc_length_total(pts)
}


///|
/// Cumulative arc lengths. / 累积弧长。
pub fn arc_length_cumulative(pts : Array[Point2D]) -> Array[Double] {
  @arc_length.arc_length_cumulative(pts)
}


///|
/// Average segment length. / 平均线段长度。
pub fn arc_length_average(pts : Array[Point2D]) -> Double {
  @arc_length.arc_length_average(pts)
}


///|
/// Max segment length. / 最大线段长度。
pub fn arc_length_max_segment(pts : Array[Point2D]) -> Double {
  @arc_length.arc_length_max_segment(pts)
}

// ---------------------------------------------------------------------------
// curvature: curvature computation / 曲率计算
// ---------------------------------------------------------------------------


///|
/// Curvature at middle point. / 中间点曲率。
pub fn curvature_at(p1 : Point2D, p2 : Point2D, p3 : Point2D) -> Double {
  @curvature.curvature_at(p1, p2, p3)
}


///|
/// Signed curvature. / 有符号曲率。
pub fn curvature_signed(p1 : Point2D, p2 : Point2D, p3 : Point2D) -> Double {
  @curvature.curvature_signed(p1, p2, p3)
}


///|
/// Curvature profile. / 曲率分布。
pub fn curvature_profile(pts : Array[Point2D]) -> Array[Double] {
  @curvature.curvature_profile(pts)
}
