///|
/// Convex polygon diameter: the farthest pair of vertices.
/// Returns (point_a, point_b, distance).
/// Uses rotating calipers on the convex hull, O(n).
///
/// 凸多边形直径：最远顶点对。返回 (点a, 点b, 距离)。
/// 在凸包上使用旋转卡壳，O(n)。
pub fn convex_polygon_diameter(
  poly : @core.Polygon,
) -> (@core.Point2D, @core.Point2D, Double) {
  let n = poly.size()
  if n == 0 {
    return (@core.Point2D::new(0.0, 0.0), @core.Point2D::new(0.0, 0.0), 0.0)
  }
  if n == 1 {
    let p = poly.get(0)
    return (p, p, 0.0)
  }
  let pts : Array[@core.Point2D] = []
  for i in 0..<n {
    pts.push(poly.get(i))
  }
  let mut j = 1
  let mut best_dist = 0.0
  let mut best_i = 0
  let mut best_j = 0
  for i in 0..<n {
    let ni = (i + 1) % n
    let mut d = pts[i].dist_sq(pts[j])
    if d > best_dist {
      best_dist = d
      best_i = i
      best_j = j
    }
    while true {
      let nj = (j + 1) % n
      let d2 = pts[i].dist_sq(pts[nj])
      let cross_val = @core.turn(pts[i], pts[ni], pts[nj])
      if d2 >= d && cross_val > 0.0 {
        j = nj
        d = d2
        if d > best_dist {
          best_dist = d
          best_i = i
          best_j = j
        }
      } else {
        break
      }
    }
  }
  (pts[best_i], pts[best_j], best_dist.sqrt())
}
