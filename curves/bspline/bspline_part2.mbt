///|
/// Evaluate B-spline curve at parameter t. / 计算 B样条曲线在参数 t 处的值。
pub fn bspline_eval(
  control_points : Array[@core.Point2D],
  degree : Int32,
  knots : Array[Double],
  t : Double,
) -> @core.Point2D {
  let n = control_points.length()
  if n == 0 {
    return @core.Point2D::new(0.0, 0.0)
  }
  let mut x = 0.0
  let mut y = 0.0
  for i in 0..<n {
    let b = bspline_basis(degree, knots, i, t)
    x += b * control_points[i].x()
    y += b * control_points[i].y()
  }
  @core.Point2D::new(x, y)
}

///|
/// Generate uniform knot vector. / 生成均匀节点向量。
pub fn uniform_knots(
  num_control_points : Int32,
  degree : Int32,
) -> Array[Double] {
  let n = num_control_points + degree + 1
  let knots : Array[Double] = []
  for i in 0..<n {
    knots.push(i.to_double())
  }
  knots
}
