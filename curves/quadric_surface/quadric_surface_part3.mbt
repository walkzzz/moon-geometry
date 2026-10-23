///|
/// Determinant of the 3x3 quadratic-form matrix. / 3x3 二次型矩阵行列式。
pub fn Quadric::quadratic_det(q : Quadric) -> Double {
  let a = 2.0 * q.a
  let b = 2.0 * q.b
  let c = 2.0 * q.c
  let d = q.d
  let e = q.e
  let f = q.f
  a * (b * c - f * f) - d * (d * c - f * e) + e * (d * f - b * e)
}
