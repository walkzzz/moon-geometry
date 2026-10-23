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