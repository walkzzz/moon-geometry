///|
/// Evaluate Lagrange interpolation polynomial at x. / 在 x 处计算 Lagrange 插值多项式。
pub fn lagrange_eval(
  xs : Array[Double],
  ys : Array[Double],
  x : Double,
) -> Double {
  let n = xs.length()
  if n == 0 || ys.length() != n {
    return 0.0
  }
  let mut result = 0.0
  for i in 0..<n {
    let mut term = ys[i]
    for j in 0..<n {
      if i != j {
        let denom = xs[i] - xs[j]
        if denom.abs() < 0.000000000001 {
          continue
        }
        term *= (x - xs[j]) / denom
      }
    }
    result += term
  }
  result
}
