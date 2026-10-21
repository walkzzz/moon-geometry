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
pub fn Point2D::dist_sq(self : Point2D, other : Point2D) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  dx * dx + dy * dy
}

///|
/// Euclidean distance to another point.
/// 到另一点的欧几里得距离。
pub fn Point2D::dist(self : Point2D, other : Point2D) -> Double {
  self.dist_sq(other).sqrt()
}

///|
/// Vector addition.
/// 向量加法。
pub fn Point2D::add(self : Point2D, other : Point2D) -> Point2D {
  { x: self.x + other.x, y: self.y + other.y, }
}

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
pub fn Point2D::dot(self : Point2D, other : Point2D) -> Double {
  self.x * other.x + self.y * other.y
}

///|
/// 2D cross product scalar (self.x * other.y - self.y * other.x).
/// 二维叉积标量 (self.x * other.y - self.y * other.x)。
pub fn Point2D::cross(self : Point2D, other : Point2D) -> Double {
  self.x * other.y - self.y * other.x
}

///|
/// Exact equality. For approximate comparison use `approx_eq`.
/// 精确相等。近似比较请用 `approx_eq`。
pub fn Point2D::equals(self : Point2D, other : Point2D) -> Bool {
  self.x == other.x && self.y == other.y
}

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

///|
/// Compare two doubles with absolute tolerance.
/// 比较两个 Double 值的绝对容差。
pub fn approx_eq(a : Double, b : Double, eps : Double) -> Bool {
  (a - b).abs() <= eps
}

///|
/// Default epsilon for geometry comparisons.
/// 几何比较的默认精度。
pub let default_eps : Double = 0.000000001

///|
pub extend Point2D with @moonbitlang/core/debug.Debug::{to_repr}

///|
pub extend Point3D with @moonbitlang/core/debug.Debug::{to_repr}

///|
/// Cross product of vectors OA and OB: (a-o) × (b-o).
/// 向量 OA 和 OB 的叉积：(a-o) × (b-o)。
/// Positive => O->A->B is a counter-clockwise turn.
/// 正值 => O->A->B 为逆时针方向。
pub fn turn(o : Point2D, a : Point2D, b : Point2D) -> Double {
  (a.x - o.x) * (b.y - o.y) - (a.y - o.y) * (b.x - o.x)
}
///|
/// Map a function over an array of 2D points.
/// 对 2D 点数组映射函数。
pub fn map_points(
  pts : Array[Point2D],
  f : (Point2D) -> Point2D,
) -> Array[Point2D] {
  let result : Array[Point2D] = []
  for p in pts {
    result.push(f(p))
  }
  result
}
///|
/// Trait for transforms that can be applied to 2D points.
/// 可应用于 2D 点的变换 trait。
pub(open) trait PointTransform {
  apply(self : Self, p : Point2D) -> Point2D
  apply_batch(self : Self, points : Array[Point2D]) -> Array[Point2D] = _
}

///|
/// Default implementation of `apply_batch` for `PointTransform`.
/// `PointTransform` 的 `apply_batch` 默认实现。
impl PointTransform with apply_batch(self, points) {
  map_points(points, fn(p) { self.apply(p) })
}
///|
/// Total length of a polyline (sum of consecutive point distances).
/// 折线总长度（相邻点距离之和）。
pub fn polyline_length(points : Array[Point2D]) -> Double {
  let n = points.length()
  if n < 2 {
    return 0.0
  }
  let mut total = 0.0
  for i in 0..<(n - 1) {
    total += points[i].dist(points[i + 1])
  }
  total
}

///|
/// Minimum distance from a point to a set of points.
/// 点到点集的最小距离。
pub fn min_dist_to_set(p : Point2D, set : Array[Point2D]) -> Double {
  if set.length() == 0 {
    return 1.0 / 0.000000000001
  }
  let mut best = p.dist(set[0])
  for q in set {
    let d = p.dist(q)
    if d < best {
      best = d
    }
  }
  best
}

///|
/// Trait for parametric 2D curves with eval, derivative, and arc length.
/// 参数化 2D 曲线 trait，提供求值、导数和弧长。
pub(open) trait Curve2D {
  eval(self : Self, t : Double) -> Point2D
  derivative(self : Self, t : Double) -> Point2D
  length(self : Self) -> Double
}
///|
/// Trait for measurable 2D shapes with area.
/// 可度量 2D 形状 trait，提供面积计算。
pub(open) trait Measurable {
  area(self : Self) -> Double
}

///|
/// Trait for shapes with a perimeter (boundary length).
/// 有周长（边界长度）的形状 trait。
pub(open) trait PerimeterMeasurable {
  perimeter(self : Self) -> Double
}

///|
/// Trait for shapes that can test point containment.
/// 可测试点包含的形状 trait。
pub(open) trait Containable {
  contains(self : Self, p : Point2D) -> Bool
}
