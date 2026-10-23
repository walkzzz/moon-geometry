///|
/// Find the antipodal pair achieving the diameter. / 找到实现直径的对踵点对。
pub fn convex_diameter_pair(
  poly : @core.Polygon,
) -> (@core.Point2D, @core.Point2D) {
  let n = poly.size()
  if n < 2 {
    let z = @core.Point2D::new(0.0, 0.0)
    return (z, z)
  }
  let mut best_i = 0
  let mut best_j = 1
  let mut max_dist = poly.get(0).dist(poly.get(1))
  for i in 0..<n {
    for j in (i + 1)..<n {
      let d = poly.get(i).dist(poly.get(j))
      if d > max_dist {
        max_dist = d
        best_i = i
        best_j = j
      }
    }
  }
  (poly.get(best_i), poly.get(best_j))
}


///|
/// Compute the radius of the minimum enclosing circle (lower bound from diameter). / 由直径计算最小包围圆半径下界。
pub fn convex_radius_lower_bound(poly : @core.Polygon) -> Double {
  convex_diameter(poly) / 2.0
}
