///|
pub fn newton_divdiff(
  xs : Array[Double],
  ys : Array[Double],
) -> Array[Double] {
  @interpolation.newton_divdiff(xs, ys)
}

///|
pub fn newton_interp(
  xs : Array[Double],
  ys : Array[Double],
  x : Double,
) -> Double {
  @interpolation.newton_interp(xs, ys, x)
}

///|
pub fn linear_interp(
  x0 : Double,
  y0 : Double,
  x1 : Double,
  y1 : Double,
  x : Double,
) -> Double {
  @interpolation.linear_interp(x0, y0, x1, y1, x)
}

///|
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
  @interpolation.bilinear_interp(x0, x1, y0, y1, f00, f10, f01, f11, x, y)
}

// ---------------------------------------------------------------------------
// eigen: Eigenvalue computation / 特征值计算
// ---------------------------------------------------------------------------

///|
pub fn power_iteration(
  matrix : Array[Array[Double]],
  n : Int,
  max_iter : Int,
) -> Double {
  @eigen.power_iteration(matrix, n, max_iter)
}

///|
pub fn jacobi_eigenvalues(
  matrix : Array[Array[Double]],
  n : Int,
  max_iter : Int,
) -> Array[Double] {
  @eigen.jacobi_eigenvalues(matrix, n, max_iter)
}

///|
pub fn matrix_trace(matrix : Array[Array[Double]], n : Int) -> Double {
  @eigen.matrix_trace(matrix, n)
}

// ---------------------------------------------------------------------------
// linalg: Linear algebra / 线性代数
// ---------------------------------------------------------------------------