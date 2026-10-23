///|
/// 2x2 matrix. / 2x2 矩阵。
pub struct Mat2 {
  a11 : Double
  a12 : Double
  a21 : Double
  a22 : Double
} derive(Debug)

///|
pub extend Mat2 with @moonbitlang/core/debug.Debug::{to_repr}

///|
/// Construct a 2x2 matrix. / 构造 2x2 矩阵。
pub fn Mat2::new(
  a11 : Double,
  a12 : Double,
  a21 : Double,
  a22 : Double,
) -> Mat2 {
  { a11, a12, a21, a22, }
}

///|
/// Identity matrix. / 单位矩阵。
pub fn Mat2::identity() -> Mat2 {
  { a11: 1.0, a12: 0.0, a21: 0.0, a22: 1.0, }
}

///|
/// Determinant. / 行列式。
pub fn Mat2::det(m : Mat2) -> Double {
  m.a11 * m.a22 - m.a12 * m.a21
}

///|
/// Matrix multiplication. / 矩阵乘法。
pub fn Mat2::mul(m : Mat2, other : Mat2) -> Mat2 {
  {
    a11: m.a11 * other.a11 + m.a12 * other.a21,
    a12: m.a11 * other.a12 + m.a12 * other.a22,
    a21: m.a21 * other.a11 + m.a22 * other.a21,
    a22: m.a21 * other.a12 + m.a22 * other.a22,
  }
}

///|
/// Apply matrix to a 2D point. / 矩阵作用于点。
pub fn Mat2::transform(m : Mat2, p : @core.Point2D) -> @core.Point2D {
  @core.Point2D::new(
    m.a11 * p.x() + m.a12 * p.y(),
    m.a21 * p.x() + m.a22 * p.y(),
  )
}

///|
/// Inverse matrix. Returns None if singular. / 逆矩阵。奇异返回 None。
pub fn Mat2::inverse(m : Mat2) -> Mat2? {
  let d = Mat2::det(m)
  if @core.approx_eq(d, 0.0, 0.000000000001) {
    return None
  }
  Some({ a11: m.a22 / d, a12: -m.a12 / d, a21: -m.a21 / d, a22: m.a11 / d, })
}

///|
/// Rotation matrix. / 旋转矩阵。
pub fn Mat2::rotation(angle : Double) -> Mat2 {
  let c = @math.cos(angle)
  let s = @math.sin(angle)
  { a11: c, a12: -s, a21: s, a22: c, }
}

///|
/// Scaling matrix. / 缩放矩阵。
pub fn Mat2::scaling(sx : Double, sy : Double) -> Mat2 {
  { a11: sx, a12: 0.0, a21: 0.0, a22: sy, }
}

///|
/// Trace of the matrix. / 矩阵的迹。
pub fn Mat2::trace(m : Mat2) -> Double {
  m.a11 + m.a22
}
