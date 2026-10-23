///|
/// Extreme point: vertex with maximum projection onto direction.
/// Returns the vertex index. O(n).
///
/// 极点：在方向 dir 上投影最大的顶点。返回顶点索引。O(n)。
pub fn extreme_point(poly : @core.Polygon, dir : @core.Point2D) -> Int {
  let n = poly.size()
  if n == 0 {
    return -1
  }
  let mut best_idx = 0
  let mut best = poly.get(0).x() * dir.x() + poly.get(0).y() * dir.y()
  for i in 1..<n {
    let val = poly.get(i).x() * dir.x() + poly.get(i).y() * dir.y()
    if val > best {
      best = val
      best_idx = i
    }
  }
  best_idx
}
