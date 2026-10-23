///|
/// Evaluate cubic Hermite spline at t. / 计算三次 Hermite 样条在 t 处的值。
pub fn hermite_eval(
  p0 : @core.Point2D,
  p1 : @core.Point2D,
  m0 : @core.Point2D,
  m1 : @core.Point2D,
  t : Double,
) -> @core.Point2D {
  let t2 = t * t
  let t3 = t2 * t
  let h00 = 2.0 * t3 - 3.0 * t2 + 1.0
  let h10 = t3 - 2.0 * t2 + t
  let h01 = -2.0 * t3 + 3.0 * t2
  let h11 = t3 - t2
  @core.Point2D::new(
    h00 * p0.x() + h10 * m0.x() + h01 * p1.x() + h11 * m1.x(),
    h00 * p0.y() + h10 * m0.y() + h01 * p1.y() + h11 * m1.y(),
  )
}

///|
/// Generate points along a Hermite spline. / 沿 Hermite 样条生成点。
pub fn hermite_points(
  points : Array[@core.Point2D],
  tangents : Array[@core.Point2D],
  num_segments : Int32,
) -> Array[@core.Point2D] {
  let n = points.length()
  if n < 2 || tangents.length() < n {
    return []
  }
  let result : Array[@core.Point2D] = []
  for i in 0..<(n - 1) {
    for j in 0..<num_segments {
      let t = j.to_double() / num_segments.to_double()
      result.push(
        hermite_eval(points[i], points[i + 1], tangents[i], tangents[i + 1], t),
      )
    }
  }
  result.push(points[n - 1])
  result
}

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
  result.push(
    @core.Point2D::new(
      s * (points[1].x() - points[0].x()),
      s * (points[1].y() - points[0].y()),
    ),
  )
  for i in 1..<(n - 1) {
    result.push(
      @core.Point2D::new(
        s * (points[i + 1].x() - points[i - 1].x()),
        s * (points[i + 1].y() - points[i - 1].y()),
      ),
    )
  }
  result.push(
    @core.Point2D::new(
      s * (points[n - 1].x() - points[n - 2].x()),
      s * (points[n - 1].y() - points[n - 2].y()),
    ),
  )
  result
}
