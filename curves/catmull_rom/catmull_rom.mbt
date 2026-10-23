///|
/// Evaluate Catmull-Rom spline at parameter t given 4 control points. / 给定4个控制点，计算 Catmull-Rom 样条在参数 t 处的值。
pub fn catmull_rom_eval(
  p0 : @core.Point2D,
  p1 : @core.Point2D,
  p2 : @core.Point2D,
  p3 : @core.Point2D,
  t : Double,
) -> @core.Point2D {
  let t2 = t * t
  let t3 = t2 * t
  let x = 0.5 *
    (
      2.0 * p1.x() +
      (-p0.x() + p2.x()) * t +
      (2.0 * p0.x() - 5.0 * p1.x() + 4.0 * p2.x() - p3.x()) * t2 +
      (-p0.x() + 3.0 * p1.x() - 3.0 * p2.x() + p3.x()) * t3
    )
  let y = 0.5 *
    (
      2.0 * p1.y() +
      (-p0.y() + p2.y()) * t +
      (2.0 * p0.y() - 5.0 * p1.y() + 4.0 * p2.y() - p3.y()) * t2 +
      (-p0.y() + 3.0 * p1.y() - 3.0 * p2.y() + p3.y()) * t3
    )
  @core.Point2D::new(x, y)
}

///|
/// Generate points along a Catmull-Rom spline through control points. / 沿控制点的 Catmull-Rom 样条生成点。
pub fn catmull_rom_points(
  control_points : Array[@core.Point2D],
  num_segments : Int32,
) -> Array[@core.Point2D] {
  let n = control_points.length()
  if n < 4 {
    return []
  }
  let result : Array[@core.Point2D] = []
  for i in 0..<(n - 3) {
    let p0 = control_points[i]
    let p1 = control_points[i + 1]
    let p2 = control_points[i + 2]
    let p3 = control_points[i + 3]
    for j in 0..<num_segments {
      let t = j.to_double() / num_segments.to_double()
      result.push(catmull_rom_eval(p0, p1, p2, p3, t))
    }
  }
  result.push(control_points[n - 2])
  result
}

///|
/// Catmull-Rom derivative at t. / Catmull-Rom 样条在 t 处的导数。
pub fn catmull_rom_derivative(
  p0 : @core.Point2D,
  p1 : @core.Point2D,
  p2 : @core.Point2D,
  p3 : @core.Point2D,
  t : Double,
) -> @core.Point2D {
  let t2 = t * t
  let x = 0.5 *
    (
      -p0.x() +
      p2.x() +
      2.0 * (2.0 * p0.x() - 5.0 * p1.x() + 4.0 * p2.x() - p3.x()) * t +
      3.0 * (-p0.x() + 3.0 * p1.x() - 3.0 * p2.x() + p3.x()) * t2
    )
  let y = 0.5 *
    (
      -p0.y() +
      p2.y() +
      2.0 * (2.0 * p0.y() - 5.0 * p1.y() + 4.0 * p2.y() - p3.y()) * t +
      3.0 * (-p0.y() + 3.0 * p1.y() - 3.0 * p2.y() + p3.y()) * t2
    )
  @core.Point2D::new(x, y)
}
