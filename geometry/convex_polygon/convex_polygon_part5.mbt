///|
/// Check if two convex polygons intersect (overlap).
/// Uses separating axis theorem: for each edge of each polygon,
/// check if it's a separating axis. O(n+m).
///
/// 检测两凸多边形是否相交（重叠）。使用分离轴定理。O(n+m)。
pub fn convex_polygons_intersect(
  poly1 : @core.Polygon,
  poly2 : @core.Polygon,
) -> Bool {
  let n1 = poly1.size()
  let n2 = poly2.size()
  if n1 == 0 || n2 == 0 {
    return false
  }
  if has_separating_axis(poly1, poly2) {
    return false
  }
  if has_separating_axis(poly2, poly1) {
    return false
  }
  true
}
