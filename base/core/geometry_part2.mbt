///|
/// Vector subtraction.
/// 向量减法。
pub fn Point2D::sub(self : Point2D, other : Point2D) -> Point2D {
  { x: self.x - other.x, y: self.y - other.y, }
}


///|
/// Scalar multiplication.
/// 标量乘法。
pub fn Point2D::mul(self : Point2D, s : Double) -> Point2D {
  { x: self.x * s, y: self.y * s, }
}


///|
/// Dot product of two vectors (treated as vectors from origin).
/// 两向量点积（视为从原点出发的向量）。
pub fn Point2D::dot(self : Point2D, other : Point2D) -> Double where {
  proof_ensure: result => result == other.x * self.x + other.y * self.y,
} {
  self.x * other.x + self.y * other.y
}


///|
/// 2D cross product scalar (self.x * other.y - self.y * other.x).
/// 二维叉积标量 (self.x * other.y - self.y * other.x)。
pub fn Point2D::cross(self : Point2D, other : Point2D) -> Double where {
  proof_ensure: result => result == -(other.x * self.y - other.y * self.x),
} {
  self.x * other.y - self.y * other.x
}


///|
/// Exact equality. For approximate comparison use `approx_eq`.
/// 精确相等。近似比较请用 `approx_eq`。
pub fn Point2D::equals(self : Point2D, other : Point2D) -> Bool {
  self.x == other.x && self.y == other.y
}
