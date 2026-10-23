///|
pub fn solve_linear(
  a : Array[Array[Double]],
  b : Array[Double],
  n : Int,
) -> Array[Double] {
  @linalg.solve_linear(a, b, n)
}

///|
pub fn determinant(a : Array[Array[Double]], n : Int) -> Double {
  @linalg.determinant(a, n)
}

///|
pub fn matrix_inverse(
  a : Array[Array[Double]],
  n : Int,
) -> Array[Array[Double]]? {
  @linalg.matrix_inverse(a, n)
}

// ---------------------------------------------------------------------------
// matrix3d: 3D matrix operations / 3D 矩阵运算
// ---------------------------------------------------------------------------

///|
pub fn identity4() -> Array[Array[Double]] {
  @matrix3d.identity4()
}

///|
pub fn translation(tx : Double, ty : Double, tz : Double) -> Array[Array[Double]] {
  @matrix3d.translation(tx, ty, tz)
}

///|
pub fn scaling(sx : Double, sy : Double, sz : Double) -> Array[Array[Double]] {
  @matrix3d.scaling(sx, sy, sz)
}

///|
pub fn rotation_x(angle : Double) -> Array[Array[Double]] {
  @matrix3d.rotation_x(angle)
}