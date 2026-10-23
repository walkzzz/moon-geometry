///|
/// Support function: max of dot(p, dir) over all vertices p.
/// Returns the maximum projection value. O(n).
///
/// 支持函数：所有顶点在方向 dir 上的最大投影值。O(n)。
pub fn support_function(poly : @core.Polygon, dir : @core.Point2D) -> Double {
  let n = poly.size()
  if n == 0 {
    return 0.0
  }
  let mut best = poly.get(0).x() * dir.x() + poly.get(0).y() * dir.y()
  for i in 1..<n {
    let val = poly.get(i).x() * dir.x() + poly.get(i).y() * dir.y()
    if val > best {
      best = val
    }
  }
  best
}
