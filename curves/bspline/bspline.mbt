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
