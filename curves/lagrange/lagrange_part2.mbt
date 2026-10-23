///|
/// Lagrange basis polynomial L_i(x). / Lagrange 基多项式 L_i(x)。
pub fn lagrange_basis(xs : Array[Double], i : Int32, x : Double) -> Double {
  let n = xs.length()
  if n == 0 {
    return 0.0
  }
  let mut result = 1.0
  for j in 0..<n {
    if i != j {
      let denom = xs[i] - xs[j]
      if denom.abs() < 0.000000000001 {
        continue
      }
      result *= (x - xs[j]) / denom
    }
  }
  result
}

///|
/// Interpolate 2D points using Lagrange interpolation (x-coordinates as nodes). / 使用 Lagrange 插值对2D点进行插值。
pub fn lagrange_interpolate(
  points : Array[@core.Point2D],
  x : Double,
) -> Double {
  let xs : Array[Double] = []
  let ys : Array[Double] = []
  for p in points {
    xs.push(p.x())
    ys.push(p.y())
  }
  lagrange_eval(xs, ys, x)
}
