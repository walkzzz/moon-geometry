///|
/// Convex polygon width: the minimum distance between parallel
/// supporting lines. Uses rotating calipers, O(n).
///
/// 凸多边形宽度：平行支撑线间的最小距离。旋转卡壳 O(n)。
pub fn convex_polygon_width(poly : @core.Polygon) -> Double {
  let n = poly.size()
  if n < 2 {
    return 0.0
  }
  let pts : Array[@core.Point2D] = []
  for i in 0..<n {
    pts.push(poly.get(i))
  }
  let mut j = 1
  let mut best_width = 999999999999999.0
  for i in 0..<n {
    let ni = (i + 1) % n
    while true {
      let nj = (j + 1) % n
      let cross_val = @core.turn(pts[i], pts[ni], pts[nj])
      if cross_val > 0.0 {
        j = nj
      } else {
        break
      }
    }
    let w = point_line_dist(pts[j], pts[i], pts[ni])
    if w < best_width {
      best_width = w
    }
  }
  best_width
}
