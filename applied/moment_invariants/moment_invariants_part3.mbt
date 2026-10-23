///|
/// Normalized central moment eta_pq = mu_pq / mu00^(1+(p+q)/2).
/// 归一化中心矩 eta_pq = mu_pq / mu00^(1+(p+q)/2)。
pub fn normalized_moment(
  points : Array[@core.Point2D],
  p : Int32,
  q : Int32,
) -> Double {
  let mu_pq = central_moment(points, p, q)
  let mu00 = central_moment(points, 0, 0)
  if mu00.abs() < 0.000000000001 {
    return 0.0
  }
  let gamma = 1.0 + (p + q).to_double() / 2.0
  mu_pq / @math.pow(mu00.abs(), gamma)
}

///|
/// Hu's seven moment invariants (translation, rotation, scale invariant).
/// Hu 七个矩不变量（平移、旋转、缩放不变）。
///
/// Returns array of 7 values. / 返回 7 个值的数组。
pub fn hu_moments(points : Array[@core.Point2D]) -> Array[Double] {
  let n20 = normalized_moment(points, 2, 0)
  let n02 = normalized_moment(points, 0, 2)
  let n11 = normalized_moment(points, 1, 1)
  let n30 = normalized_moment(points, 3, 0)
  let n03 = normalized_moment(points, 0, 3)
  let n12 = normalized_moment(points, 1, 2)
  let n21 = normalized_moment(points, 2, 1)
  let h1 = n20 + n02
  let h2 = (n20 - n02) * (n20 - n02) + 4.0 * n11 * n11
  let h3 = (n30 - 3.0 * n12) * (n30 - 3.0 * n12) +
    (3.0 * n21 - n03) * (3.0 * n21 - n03)
  let h4 = (n30 + n12) * (n30 + n12) + (n21 + n03) * (n21 + n03)
  let h5 = (n30 - 3.0 * n12) *
    (n30 + n12) *
    ((n30 + n12) * (n30 + n12) - 3.0 * (n21 + n03) * (n21 + n03)) +
    (3.0 * n21 - n03) *
    (n21 + n03) *
    (3.0 * (n30 + n12) * (n30 + n12) - (n21 + n03) * (n21 + n03))
  let h6 = (n20 - n02) * ((n30 + n12) * (n30 + n12) - (n21 + n03) * (n21 + n03)) +
    4.0 * n11 * (n30 + n12) * (n21 + n03)
  let h7 = (3.0 * n21 - n03) *
    (n30 + n12) *
    ((n30 + n12) * (n30 + n12) - 3.0 * (n21 + n03) * (n21 + n03)) -
    (n30 - 3.0 * n12) *
    (n21 + n03) *
    (3.0 * (n30 + n12) * (n30 + n12) - (n21 + n03) * (n21 + n03))
  [h1, h2, h3, h4, h5, h6, h7]
}

///|
/// Zernike radial polynomial R_n^m(r).
/// Zernike 径向多项式 R_n^m(r)。
fn zernike_radial(n : Int32, m : Int32, r : Double) -> Double {
  let mut result = 0.0
  let s_max = (n - m) / 2
  for s in 0..<=s_max {
    let sign = if s % 2 == 0 { 1.0 } else { -1.0 }
    let num = factorial(n - s)
    let den = factorial(s) *
      factorial((n + m) / 2 - s) *
      factorial((n - m) / 2 - s)
    result += sign * num / den * powi(r, n - 2 * s)
  }
  result
}
