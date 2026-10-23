///|
/// Axis-aligned bounding box of a point set.
/// 点集的轴对齐包围盒。
pub fn aabb(points : Array[@core.Point2D]) -> @core.Rectangle {
  let n = points.length()
  if n == 0 {
    return @core.Rectangle::new(0.0, 0.0, 0.0, 0.0)
  }
  let mut min_x = points[0].x
  let mut max_x = points[0].x
  let mut min_y = points[0].y
  let mut max_y = points[0].y
  for i in 1..<n {
    if points[i].x < min_x {
      min_x = points[i].x
    }
    if points[i].x > max_x {
      max_x = points[i].x
    }
    if points[i].y < min_y {
      min_y = points[i].y
    }
    if points[i].y > max_y {
      max_y = points[i].y
    }
  }
  @core.Rectangle::new(min_x, min_y, max_x, max_y)
}
