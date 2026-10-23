///|
/// Farthest point pair from a set of points.
/// Computes convex hull first, then rotating calipers.
/// Returns None if fewer than 2 points.
///
/// 点集最远点对。先求凸包再旋转卡壳。少于 2 点返回 None。
pub fn farthest_point_pair(
  points : Array[@core.Point2D],
) -> (@core.Point2D, @core.Point2D, Double)? {
  if points.length() < 2 {
    return None
  }
  let hull_pts = @hull.convex_hull_andrew(points)
  if hull_pts.length() < 2 {
    return None
  }
  let hull_poly = @core.Polygon::new(hull_pts)
  Some(convex_polygon_diameter(hull_poly))
}
