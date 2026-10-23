///|
/// Determinant. / 行列式。
pub fn mat2_det(m : Mat2) -> Double {
  @matrix.Mat2::det(m)
}


///|
/// Matrix multiplication. / 矩阵乘法。
pub fn mat2_mul(m : Mat2, other : Mat2) -> Mat2 {
  @matrix.Mat2::mul(m, other)
}


///|
/// Apply matrix to a 2D point. / 矩阵作用于点。
pub fn mat2_transform(m : Mat2, p : Point2D) -> Point2D {
  @matrix.Mat2::transform(m, p)
}


///|
/// Inverse matrix. Returns None if singular. / 逆矩阵。奇异返回 None。
pub fn mat2_inverse(m : Mat2) -> Mat2? {
  @matrix.Mat2::inverse(m)
}


///|
/// Rotation matrix. / 旋转矩阵。
pub fn mat2_rotation(angle : Double) -> Mat2 {
  @matrix.Mat2::rotation(angle)
}


///|
/// Scaling matrix. / 缩放矩阵。
pub fn mat2_scaling(sx : Double, sy : Double) -> Mat2 {
  @matrix.Mat2::scaling(sx, sy)
}
