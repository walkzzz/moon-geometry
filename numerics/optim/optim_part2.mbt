///|
/// Find the minimum area rectangle enclosing a set of points. / 找到包围点集的最小面积矩形。
pub fn min_area_rect(
  points : Array[@core.Point2D],
) -> @core.Rectangle {
  if points.length() == 0 {
    return @core.Rectangle::new(0.0, 0.0, 0.0, 0.0)
  }
  let mut min_x = points[0].x()
  let mut max_x = points[0].x()
  let mut min_y = points[0].y()
  let mut max_y = points[0].y()
  for p in points {
    min_x = min_x.min(p.x())
    max_x = max_x.max(p.x())
    min_y = min_y.min(p.y())
    max_y = max_y.max(p.y())
  }
  @core.Rectangle::new(min_x, min_y, max_x, max_y)
}


///|
/// Compute the centroid of a set of points. / 计算点集的质心。
pub fn centroid(
  points : Array[@core.Point2D],
) -> @core.Point2D {
  if points.length() == 0 {
    return @core.Point2D::new(0.0, 0.0)
  }
  let mut sx = 0.0
  let mut sy = 0.0
  for p in points {
    sx += p.x()
    sy += p.y()
  }
  let n = points.length().to_double()
  @core.Point2D::new(sx / n, sy / n)
}
