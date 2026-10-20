///|
/// B-spline basis function (Cox-de Boor recursion). / B样条基函数（Cox-de Boor 递归）。
pub fn bspline_basis(
  degree : Int,
  knots : Array[Double],
  i : Int,
  t : Double,
) -> Double {
  if degree == 0 {
    if t >= knots[i] && t < knots[i + 1] {
      return 1.0
    }
    return 0.0
  }
  let eps = 0.000000000001
  let mut result = 0.0
  let denom1 = knots[i + degree] - knots[i]
  if denom1.abs() > eps {
    result += (t - knots[i]) / denom1 * bspline_basis(degree - 1, knots, i, t)
  }
  let denom2 = knots[i + degree + 1] - knots[i + 1]
  if denom2.abs() > eps {
    result += (knots[i + degree + 1] - t) / denom2 * bspline_basis(degree - 1, knots, i + 1, t)
  }
  result
}

///|
/// Evaluate B-spline curve at parameter t. / 计算 B样条曲线在参数 t 处的值。
pub fn bspline_eval(
  control_points : Array[@core.Point2D],
  degree : Int,
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
  num_control_points : Int,
  degree : Int,
) -> Array[Double] {
  let n = num_control_points + degree + 1
  let knots : Array[Double] = []
  for i in 0..<n {
    knots.push(i.to_double())
  }
  knots
}

///|
/// Generate points along a B-spline curve. / 沿 B样条曲线生成点。
pub fn bspline_points(
  control_points : Array[@core.Point2D],
  degree : Int,
  num_samples : Int,
) -> Array[@core.Point2D] {
  let n = control_points.length()
  if n < degree + 1 {
    return []
  }
  let knots = uniform_knots(n, degree)
  let result : Array[@core.Point2D] = []
  let t_min = knots[degree]
  let t_max = knots[n]
  for i in 0..<num_samples {
    let t = t_min + (t_max - t_min) * i.to_double() / (num_samples - 1).to_double()
    result.push(bspline_eval(control_points, degree, knots, t))
  }
  result
}