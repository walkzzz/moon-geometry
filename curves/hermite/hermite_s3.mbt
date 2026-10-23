///|
/// Hermite spline derivative at t. / Hermite 样条在 t 处的导数。
pub fn hermite_derivative(
  p0 : @core.Point2D,
  p1 : @core.Point2D,
  m0 : @core.Point2D,
  m1 : @core.Point2D,
  t : Double,
) -> @core.Point2D {
  let t2 = t * t
  let dh00 = 6.0 * t2 - 6.0 * t
  let dh10 = 3.0 * t2 - 4.0 * t + 1.0
  let dh01 = -6.0 * t2 + 6.0 * t
  let dh11 = 3.0 * t2 - 2.0 * t
  @core.Point2D::new(
    dh00 * p0.x() + dh10 * m0.x() + dh01 * p1.x() + dh11 * m1.x(),
    dh00 * p0.y() + dh10 * m0.y() + dh01 * p1.y() + dh11 * m1.y(),
  )
}


///|
/// Compute Cardinal spline tangents (special case of Hermite). / 计算 Cardinal 样条切线（Hermite 特例）。
pub fn cardinal_tangents(
  points : Array[@core.Point2D],
  tension : Double,
) -> Array[@core.Point2D] {
  let n = points.length()
  if n < 3 {
    return []
  }
  let result : Array[@core.Point2D] = []
  let s = (1.0 - tension) / 2.0
  result.push(@core.Point2D::new(
    s * (points[1].x() - points[0].x()),
    s * (points[1].y() - points[0].y()),
  ))
  for i in 1..<(n - 1) {
    result.push(@core.Point2D::new(
      s * (points[i + 1].x() - points[i - 1].x()),
      s * (points[i + 1].y() - points[i - 1].y()),
    ))
  }
  result.push(@core.Point2D::new(
    s * (points[n - 1].x() - points[n - 2].x()),
    s * (points[n - 1].y() - points[n - 2].y()),
  ))
  result
}