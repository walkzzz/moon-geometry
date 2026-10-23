///|
/// Two-dimensional point with Double coordinates.
/// 使用 Double 坐标的二维点。
pub struct Point2D {
  x : Double
  y : Double
} derive(Debug)


///|
/// Construct a 2D point.
/// 构造二维点。
pub fn Point2D::new(x : Double, y : Double) -> Point2D {
  { x, y, }
}


///|
/// X coordinate accessor.
/// X 坐标访问器。
pub fn Point2D::x(self : Point2D) -> Double {
  self.x
}


///|
/// Y coordinate accessor.
/// Y 坐标访问器。
pub fn Point2D::y(self : Point2D) -> Double {
  self.y
}


///|
/// Squared distance to another point.
/// 到另一点的距离平方。
pub fn Point2D::dist_sq(self : Point2D, other : Point2D) -> Double where {
  proof_ensure: result => result >= 0.0,
} {
  let dx = self.x - other.x
  let dy = self.y - other.y
  dx * dx + dy * dy
}


///|
/// Euclidean distance to another point.
/// 到另一点的欧几里得距离。
pub fn Point2D::dist(self : Point2D, other : Point2D) -> Double where {
  proof_ensure: result => result >= 0.0,
} {
  self.dist_sq(other).sqrt()
}


///|
/// Vector addition.
/// 向量加法。
pub fn Point2D::add(self : Point2D, other : Point2D) -> Point2D {
  { x: self.x + other.x, y: self.y + other.y, }
}
