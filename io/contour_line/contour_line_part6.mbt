///|
/// Count total contour segments at a level. / 统计某等值层的线段总数。
pub fn count_contour_segments(g : ContourGrid, level : Double) -> Int32 {
  marching_squares(g, level).length()
}
