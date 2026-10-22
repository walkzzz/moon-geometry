///|
/// Support function: index of point maximizing dot product with direction. / 支持函数：最大化点积的点索引。
pub fn support_point_set(
  points : Array[@core.Point2D],
  dir : @core.Point2D,
) -> Int? {
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

///|
/// Support point of a circle in a direction. / 圆在方向上的支持点。
pub fn support_circle(
  center : @core.Point2D,
  radius : Double,
  dir : @core.Point2D,
) -> @core.Point2D {
  let dlen = (dir.x() * dir.x() + dir.y() * dir.y()).sqrt()
  if dlen < 0.000000000001 {
    return center
  }
  @core.Point2D::new(
    center.x() + radius * dir.x() / dlen,
    center.y() + radius * dir.y() / dlen,
  )
}

///|
/// Support value (max dot product) for a point set. / 点集的支持值。
pub fn support_value(
  points : Array[@core.Point2D],
  dir : @core.Point2D,
) -> Double? {
  match support_point_set(points, dir) {
    Some(idx) => Some(points[idx].x() * dir.x() + points[idx].y() * dir.y())
    None => None
  }
}

///|
/// Support point of a segment in a direction. / 线段在方向上的支持点。
pub fn support_segment(
  seg : @core.Segment,
  dir : @core.Point2D,
) -> @core.Point2D {
  let va = seg.start.x() * dir.x() + seg.start.y() * dir.y()
  let vb = seg.end.x() * dir.x() + seg.end.y() * dir.y()
  if va >= vb {
    seg.start
  } else {
    seg.end
  }
}

///|
/// Width of a point set in a direction (support - (-support)). / 点集在方向上的宽度。
pub fn width_in_direction(
  points : Array[@core.Point2D],
  dir : @core.Point2D,
) -> Double {
  match support_value(points, dir) {
    Some(max_val) => {
      let neg_dir = @core.Point2D::new(-dir.x(), -dir.y())
      match support_value(points, neg_dir) {
        Some(min_val) => max_val + min_val
        None => 0.0
      }
    }
    None => 0.0
  }
}