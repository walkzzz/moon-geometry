///|
/// Support function: index of point maximizing dot product with direction. / 支持函数：最大化点积的点索引。
pub fn support_point_set(
  points : Array[@core.Point2D],
  dir : @core.Point2D,
) -> Int32? {
  if points.length() == 0 {
    return None
  }
  let mut best_idx = 0
  let mut best_val = points[0].x() * dir.x() + points[0].y() * dir.y()
  for i in 1..<points.length() {
    let val = points[i].x() * dir.x() + points[i].y() * dir.y()
    if val > best_val {
      best_val = val
      best_idx = i
    }
  }
  Some(best_idx)
}
