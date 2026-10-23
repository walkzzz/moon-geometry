///|
/// Check if a convex polygon contains a point using SAT. / 使用 SAT 检测凸多边形是否包含点。
pub fn sat_contains_point(
  poly : Array[@core.Point2D],
  p : @core.Point2D,
) -> Bool {
  let axes = get_edge_axes(poly)
  for i in 0..<axes.length() {
    let (ax, ay) = axes[i]
    let (min_val, max_val) = project_polygon(poly, ax, ay)
    let proj = p.x() * ax + p.y() * ay
    if proj < min_val || proj > max_val {
      return false
    }
  }
  true
}
