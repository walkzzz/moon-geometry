///|
/// Approximate equality with absolute tolerance.
/// 绝对容差近似相等。
pub fn Point2D::approx_eq(
  self : Point2D,
  other : Point2D,
  eps : Double,
) -> Bool {
  (self.x - other.x).abs() <= eps && (self.y - other.y).abs() <= eps
}


///|
/// Three-dimensional point with Double coordinates.
/// 使用 Double 坐标的三维点。
pub struct Point3D {
  x : Double
  y : Double
  z : Double
} derive(Debug)


///|
/// Construct a 3D point.
/// 构造三维点。
pub fn Point3D::new(x : Double, y : Double, z : Double) -> Point3D {
  { x, y, z, }
}


///|
/// Squared distance to another point.
/// 到另一点的距离平方。
pub fn Point3D::dist_sq(self : Point3D, other : Point3D) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  dx * dx + dy * dy + dz * dz
}


///|
/// Euclidean distance to another point.
/// 到另一点的欧几里得距离。
pub fn Point3D::dist(self : Point3D, other : Point3D) -> Double {
  self.dist_sq(other).sqrt()
}


///|
/// Vector addition.
/// 向量加法。
pub fn Point3D::add(self : Point3D, other : Point3D) -> Point3D {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, }
}
