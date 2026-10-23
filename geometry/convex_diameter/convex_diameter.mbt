///|
/// Compute the diameter of a convex polygon (maximum distance between any two vertices). / 计算凸多边形的直径（任意两顶点间最大距离）。
pub fn convex_diameter(poly : @core.Polygon) -> Double {
  let n = poly.size()
  if n < 2 {
    return 0.0
  }
  let mut max_dist = 0.0
  for i in 0..<n {
    for j in (i + 1)..<n {
      let d = poly.get(i).dist(poly.get(j))
      if d > max_dist {
        max_dist = d
      }
    }
  }
  max_dist
}
