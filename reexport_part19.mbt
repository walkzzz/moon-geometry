///|
/// Perpendicular vector (rotated 90° CCW). / 垂直向量（逆时针旋转90°）。
pub fn vec_perp(v : Point2D) -> Point2D {
  @vector.perp(v)
}


///|
/// Vector length. / 向量长度。
pub fn vec_length(v : Point2D) -> Double {
  @vector.length(v)
}


///|
/// Angle between two vectors in radians. / 两向量夹角（弧度）。
pub fn vec_angle_between(a : Point2D, b : Point2D) -> Double {
  @vector.angle_between(a, b)
}


///|
/// Reject component of v along u. / 拒绝分量。
pub fn vec_reject(v : Point2D, u : Point2D) -> Point2D {
  @vector.reject(v, u)
}

// ---------------------------------------------------------------------------
// matrix: 2x2 matrix / 2x2 矩阵
// ---------------------------------------------------------------------------


///|
/// 2x2 matrix type. / 2x2 矩阵类型。
pub type Mat2 = @matrix.Mat2


///|
/// Construct a 2x2 matrix. / 构造 2x2 矩阵。
pub fn mat2_new(a11 : Double, a12 : Double, a21 : Double, a22 : Double) -> Mat2 {
  @matrix.Mat2::new(a11, a12, a21, a22)
}


///|
/// Identity matrix. / 单位矩阵。
pub fn mat2_identity() -> Mat2 {
  @matrix.Mat2::identity()
}
