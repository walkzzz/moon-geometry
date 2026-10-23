///|
/// Scale a point set by a factor. / 缩放点集。
pub fn point_set_scale(
  points : Array[@core.Point2D],
  factor : Double,
) -> Array[@core.Point2D] {
  let result : Array[@core.Point2D] = []
  for i in 0..<points.length() {
    result.push(
      @core.Point2D::new(points[i].x() * factor, points[i].y() * factor),
    )
  }
  result
}

///|
/// Translate a point set. / 平移点集。
pub fn point_set_translate(
  points : Array[@core.Point2D],
  dx : Double,
  dy : Double,
) -> Array[@core.Point2D] {
  let result : Array[@core.Point2D] = []
  for i in 0..<points.length() {
    result.push(@core.Point2D::new(points[i].x() + dx, points[i].y() + dy))
  }
  result
}

///|
/// Centroid of a point set. / 点集质心。
pub fn point_set_centroid(points : Array[@core.Point2D]) -> @core.Point2D? {
  if points.length() == 0 {
    return None
  }
  let mut sx = 0.0
  let mut sy = 0.0
  for i in 0..<points.length() {
    sx += points[i].x()
    sy += points[i].y()
  }
  let n = points.length().to_double()
  Some(@core.Point2D::new(sx / n, sy / n))
}
