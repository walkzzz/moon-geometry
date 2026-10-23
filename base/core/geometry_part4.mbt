///|
/// Vector subtraction.
/// 向量减法。
pub fn Point3D::sub(self : Point3D, other : Point3D) -> Point3D {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, }
}

///|
/// Scalar multiplication.
/// 标量乘法。
pub fn Point3D::mul(self : Point3D, s : Double) -> Point3D {
  { x: self.x * s, y: self.y * s, z: self.z * s, }
}

///|
/// Dot product.
/// 点积。
pub fn Point3D::dot(self : Point3D, other : Point3D) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
/// 3D cross product vector.
/// 三维叉积向量。
pub fn Point3D::cross(self : Point3D, other : Point3D) -> Point3D {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
  }
}

///|
/// Approximate equality with absolute tolerance.
/// 绝对容差近似相等。
pub fn Point3D::approx_eq(
  self : Point3D,
  other : Point3D,
  eps : Double,
) -> Bool {
  (self.x - other.x).abs() <= eps &&
  (self.y - other.y).abs() <= eps &&
  (self.z - other.z).abs() <= eps
}
