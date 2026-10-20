/// |
/// # Interpolation
/// # 插值
///
/// Lagrange and Newton interpolation methods.
/// Lagrange 和 Newton 插值方法。
///
/// ## Complexity: O(n²) for construction, O(n) for evaluation
/// ## 复杂度: 构建 O(n²)，求值 O(n)

/// |
/// Lagrange interpolation at point x.
/// Lagrange 插值在点 x 处求值。
///
/// # Arguments / 参数
/// - `xs`: x-coordinates / x 坐标
/// - `ys`: y-coordinates / y 坐标
/// - `x`: evaluation point / 求值点
pub fn lagrange_interp(
  xs : Array[Double],
  ys : Array[Double],
  x : Double,
) -> Double {
  let n = xs.length()
  if n == 0 {
    return 0.0
  }
  let mut result = 0.0
  for i in 0..<n {
    let mut term = ys[i]
    for j in 0..<n {
      if i != j {
        term *= (x - xs[j]) / (xs[i] - xs[j])
      }
    }
    result += term
  }
  result
}

/// |
/// Newton divided differences.
/// Newton 差商。
pub fn newton_divdiff(
  xs : Array[Double],
  ys : Array[Double],
) -> Array[Double] {
  let n = xs.length()
  let table : Array[Array[Double]] = []
  for i in 0..<n {
    let row : Array[Double] = []
    for j in 0..<n {
      if j == 0 {
        row.push(ys[i])
      } else {
        row.push(0.0)
      }
    }
    table.push(row)
  }
  for j in 1..<n {
    for i in 0..<(n - j) {
      table[i][j] = (table[i + 1][j - 1] - table[i][j - 1]) / (xs[i + j] - xs[i])
    }
  }
  let coeffs : Array[Double] = []
  for j in 0..<n {
    coeffs.push(table[0][j])
  }
  coeffs
}

/// |
/// Newton interpolation at point x.
/// Newton 插值在点 x 处求值。
pub fn newton_interp(
  xs : Array[Double],
  ys : Array[Double],
  x : Double,
) -> Double {
  let coeffs = newton_divdiff(xs, ys)
  let n = coeffs.length()
  let mut result = coeffs[n - 1]
  let mut i = n - 2
  while i >= 0 {
    result = result * (x - xs[i]) + coeffs[i]
    i -= 1
  }
  result
}

/// |
/// Linear interpolation between two points.
/// 两点间的线性插值。
pub fn linear_interp(
  x0 : Double,
  y0 : Double,
  x1 : Double,
  y1 : Double,
  x : Double,
) -> Double {
  if (x1 - x0).abs() < 0.0000000001 {
    return y0
  }
  y0 + (y1 - y0) * (x - x0) / (x1 - x0)
}

/// |
/// Bilinear interpolation on a grid.
/// 网格上的双线性插值。
pub fn bilinear_interp(
  x0 : Double,
  x1 : Double,
  y0 : Double,
  y1 : Double,
  f00 : Double,
  f10 : Double,
  f01 : Double,
  f11 : Double,
  x : Double,
  y : Double,
) -> Double {
  let tx = (x - x0) / (x1 - x0)
  let ty = (y - y0) / (y1 - y0)
  f00 * (1.0 - tx) * (1.0 - ty) +
    f10 * tx * (1.0 - ty) +
    f01 * (1.0 - tx) * ty +
    f11 * tx * ty
}