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

///|
/// Check if interpolation nodes are distinct. / 检查插值节点是否互异。
pub fn lagrange_nodes_distinct(xs : Array[Double]) -> Bool {
  let n = xs.length()
  for i in 0..<n {
    for j in (i + 1)..<n {
      if (xs[i] - xs[j]).abs() < 0.000000000001 {
        return false
      }
    }
  }
  true
}
