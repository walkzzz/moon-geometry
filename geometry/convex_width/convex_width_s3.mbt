///|
/// Compute the aspect ratio of a convex polygon (max_width / min_width). / 计算凸多边形的宽高比（最大宽度/最小宽度）。
pub fn convex_aspect_ratio(poly : @core.Polygon) -> Double {
  let mw = convex_width(poly)
  if mw < 0.000000001 {
    return 0.0
  }
  convex_max_width(poly) / mw
}