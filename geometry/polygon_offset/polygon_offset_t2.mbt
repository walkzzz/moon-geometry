///|
/// Offset a polygon inward by a distance. / 将多边形向内偏移指定距离。
pub fn polygon_offset_inward(
  poly : Array[@core.Point2D],
  dist : Double,
) -> Array[@core.Point2D] {
  polygon_offset_outward(poly, -dist)
}
