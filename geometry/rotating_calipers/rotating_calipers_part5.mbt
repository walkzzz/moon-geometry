///|
/// Minimum perimeter bounding rectangle of a convex polygon.
/// Uses rotating calipers, O(n). Returns (cx, cy, width, height, angle).
///
/// 凸多边形最小周长包围矩形。旋转卡壳 O(n)。返回 (cx, cy, 宽, 高, 角度)。
pub fn min_perimeter_bounding_rect(
  poly : @core.Polygon,
) -> (Double, Double, Double, Double, Double) {
  let n = poly.size()
  if n < 3 {
    return (0.0, 0.0, 0.0, 0.0, 0.0)
  }
  let pts : Array[@core.Point2D] = []
  for i in 0..<n {
    pts.push(poly.get(i))
  }
  let mut j = 1
  let mut best_perim = 999999999999999.0
  let mut best_cx = 0.0
  let mut best_cy = 0.0
  let mut best_w = 0.0
  let mut best_h = 0.0
  let mut best_angle = 0.0
  for i in 0..<n {
    let ni = (i + 1) % n
    let dx = pts[ni].x() - pts[i].x()
    let dy = pts[ni].y() - pts[i].y()
    let edge_len = (dx * dx + dy * dy).sqrt()
    if edge_len < @core.default_eps {
      continue
    }
    while true {
      let nj = (j + 1) % n
      let cross_val = @core.turn(pts[i], pts[ni], pts[nj])
      if cross_val > 0.0 {
        j = nj
      } else {
        break
      }
    }
    let ex = dx / edge_len
    let ey = dy / edge_len
    let nx = -ey
    let ny = ex
    let mut min_p = pts[i].x() * ex + pts[i].y() * ey
    let mut max_p = min_p
    let mut min_q = pts[i].x() * nx + pts[i].y() * ny
    let mut max_q = min_q
    for k in 0..<n {
      let pp = pts[k].x() * ex + pts[k].y() * ey
      let qq = pts[k].x() * nx + pts[k].y() * ny
      if pp < min_p {
        min_p = pp
      }
      if pp > max_p {
        max_p = pp
      }
      if qq < min_q {
        min_q = qq
      }
      if qq > max_q {
        max_q = qq
      }
    }
    let w = max_p - min_p
    let h = max_q - min_q
    let perim = 2.0 * (w + h)
    if perim < best_perim {
      best_perim = perim
      best_w = w
      best_h = h
      best_cx = (min_p + max_p) / 2.0 * ex + (min_q + max_q) / 2.0 * nx
      best_cy = (min_p + max_p) / 2.0 * ey + (min_q + max_q) / 2.0 * ny
      best_angle = @math.atan2(ey, ex)
    }
  }
  (best_cx, best_cy, best_w, best_h, best_angle)
}
