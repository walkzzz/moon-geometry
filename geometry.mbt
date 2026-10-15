///|
/// Two-dimensional point with Double coordinates.
pub struct Point2D {
  x : Double
  y : Double
} derive(Debug)

///|
/// Construct a 2D point.
pub fn Point2D::new(x : Double, y : Double) -> Point2D {
  { x, y, }
}

///|
/// X coordinate accessor.
pub fn Point2D::x(self : Point2D) -> Double {
  self.x
}

///|
/// Y coordinate accessor.
pub fn Point2D::y(self : Point2D) -> Double {
  self.y
}

///|
/// Squared distance to another point.
pub fn Point2D::dist_sq(self : Point2D, other : Point2D) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  dx * dx + dy * dy
}

///|
/// Euclidean distance to another point.
pub fn Point2D::dist(self : Point2D, other : Point2D) -> Double {
  self.dist_sq(other).sqrt()
}

///|
/// Vector addition.
pub fn Point2D::add(self : Point2D, other : Point2D) -> Point2D {
  { x: self.x + other.x, y: self.y + other.y, }
}

///|
/// Vector subtraction.
pub fn Point2D::sub(self : Point2D, other : Point2D) -> Point2D {
  { x: self.x - other.x, y: self.y - other.y, }
}

///|
/// Scalar multiplication.
pub fn Point2D::mul(self : Point2D, s : Double) -> Point2D {
  { x: self.x * s, y: self.y * s, }
}

///|
/// Dot product of two vectors (treated as vectors from origin).
pub fn Point2D::dot(self : Point2D, other : Point2D) -> Double {
  self.x * other.x + self.y * other.y
}

///|
/// 2D cross product scalar (self.x * other.y - self.y * other.x).
pub fn Point2D::cross(self : Point2D, other : Point2D) -> Double {
  self.x * other.y - self.y * other.x
}

///|
/// Exact equality. For approximate comparison use `approx_eq`.
pub fn Point2D::equals(self : Point2D, other : Point2D) -> Bool {
  self.x == other.x && self.y == other.y
}

///|
/// Approximate equality with absolute tolerance.
pub fn Point2D::approx_eq(
  self : Point2D,
  other : Point2D,
  eps : Double,
) -> Bool {
  (self.x - other.x).abs() <= eps && (self.y - other.y).abs() <= eps
}

///|
/// Three-dimensional point with Double coordinates.
pub struct Point3D {
  x : Double
  y : Double
  z : Double
} derive(Debug)

///|
/// Construct a 3D point.
pub fn Point3D::new(x : Double, y : Double, z : Double) -> Point3D {
  { x, y, z, }
}

///|
/// Squared distance to another point.
pub fn Point3D::dist_sq(self : Point3D, other : Point3D) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  dx * dx + dy * dy + dz * dz
}

///|
/// Euclidean distance to another point.
pub fn Point3D::dist(self : Point3D, other : Point3D) -> Double {
  self.dist_sq(other).sqrt()
}

///|
/// Vector addition.
pub fn Point3D::add(self : Point3D, other : Point3D) -> Point3D {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, }
}

///|
/// Vector subtraction.
pub fn Point3D::sub(self : Point3D, other : Point3D) -> Point3D {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, }
}

///|
/// Scalar multiplication.
pub fn Point3D::mul(self : Point3D, s : Double) -> Point3D {
  { x: self.x * s, y: self.y * s, z: self.z * s, }
}

///|
/// Dot product.
pub fn Point3D::dot(self : Point3D, other : Point3D) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

///|
/// 3D cross product vector.
pub fn Point3D::cross(self : Point3D, other : Point3D) -> Point3D {
  {
    x: self.y * other.z - self.z * other.y,
    y: self.z * other.x - self.x * other.z,
    z: self.x * other.y - self.y * other.x,
  }
}

///|
/// Approximate equality with absolute tolerance.
pub fn Point3D::approx_eq(
  self : Point3D,
  other : Point3D,
  eps : Double,
) -> Bool {
  (self.x - other.x).abs() <= eps &&
  (self.y - other.y).abs() <= eps &&
  (self.z - other.z).abs() <= eps
}

///|
/// Compare two doubles with absolute tolerance.
pub fn approx_eq(a : Double, b : Double, eps : Double) -> Bool {
  (a - b).abs() <= eps
}

///|
/// Default epsilon for geometry comparisons.
pub let default_eps : Double = 0.000000001

///|
pub extend Point2D with @moonbitlang/core/debug.Debug::{to_repr}

///|
pub extend Point3D with @moonbitlang/core/debug.Debug::{to_repr}
