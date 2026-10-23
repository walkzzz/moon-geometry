///|
/// Orientation of an ordered point sequence.
/// 有序点序列的方向。
pub(all) enum Orientation {
  Clockwise
  CounterClockwise
  Collinear
} derive(Debug, Eq)

///|
/// A polygon as an ordered sequence of vertices.
/// 由有序顶点序列定义的多边形。
pub struct Polygon {
  vertices : Array[Point2D]
} derive(Debug)

///|
/// Construct a polygon from a vertex array.
/// 从顶点数组构造多边形。
pub fn Polygon::new(vertices : Array[Point2D]) -> Polygon {
  { vertices, }
}

///|
/// Number of vertices.
/// 顶点数量。
pub fn Polygon::size(self : Polygon) -> Int32 {
  self.vertices.length()
}

///|
/// Get the i-th vertex (with modular wraparound).
/// 获取第 i 个顶点（带模环绕）。
pub fn Polygon::get(self : Polygon, i : Int32) -> Point2D {
  let n = self.vertices.length()
  if n == 0 {
    abort("Polygon::get: empty polygon")
  }
  let idx = (i % n + n) % n
  self.vertices[idx]
}

///|
/// A triangle defined by three vertices.
/// 由三个顶点定义的三角形。
pub struct Triangle {
  a : Point2D
  b : Point2D
  c : Point2D
} derive(Debug)

///|
pub extend Triangle with @moonbitlang/core/debug.Debug::{to_repr}

///|
pub extend Triangle with Measurable::{area}

///|
/// Construct a triangle.
/// 构造三角形。
pub fn Triangle::new(a : Point2D, b : Point2D, c : Point2D) -> Triangle {
  { a, b, c, }
}

///|
/// Signed area of the triangle (positive if CCW).
/// 三角形有符号面积（逆时针为正）。
pub fn Triangle::signed_area(self : Triangle) -> Double {
  (
    (self.b.x - self.a.x) * (self.c.y - self.a.y) -
    (self.c.x - self.a.x) * (self.b.y - self.a.y)
  ) /
  2.0
}

///|
/// Absolute area of the triangle.
/// 三角形绝对面积。
pub impl Measurable for Triangle with fn area(self) {
  self.signed_area().abs()
}

///|
/// Centroid (intersection of medians).
/// 重心（中线交点）。
pub fn Triangle::centroid(self : Triangle) -> Point2D {
  Point2D::new(
    (self.a.x + self.b.x + self.c.x) / 3.0,
    (self.a.y + self.b.y + self.c.y) / 3.0,
  )
}

///|
/// Circumcenter (center of circumscribed circle).
/// 外心（外接圆中心）。
pub fn Triangle::circumcenter(self : Triangle) -> Point2D {
  let ax = self.a.x
  let ay = self.a.y
  let bx = self.b.x
  let by = self.b.y
  let cx = self.c.x
  let cy = self.c.y
  let d = 2.0 * (ax * (by - cy) + bx * (cy - ay) + cx * (ay - by))
  if d == 0.0 {
    abort("Triangle::circumcenter: degenerate (collinear) triangle")
  }
  let ux = (
      (ax * ax + ay * ay) * (by - cy) +
      (bx * bx + by * by) * (cy - ay) +
      (cx * cx + cy * cy) * (ay - by)
    ) /
    d
  let uy = (
      (ax * ax + ay * ay) * (cx - bx) +
      (bx * bx + by * by) * (ax - cx) +
      (cx * cx + cy * cy) * (bx - ax)
    ) /
    d
  Point2D::new(ux, uy)
}

///|
/// Incenter (center of inscribed circle).
/// 内心（内切圆中心）。
pub fn Triangle::incenter(self : Triangle) -> Point2D {
  let a_len = self.b.dist(self.c)
  let b_len = self.a.dist(self.c)
  let c_len = self.a.dist(self.b)
  let perim = a_len + b_len + c_len
  if perim == 0.0 {
    abort("Triangle::incenter: degenerate triangle")
  }
  Point2D::new(
    (a_len * self.a.x + b_len * self.b.x + c_len * self.c.x) / perim,
    (a_len * self.a.y + b_len * self.b.y + c_len * self.c.y) / perim,
  )
}

///|
/// A circle defined by center and radius.
/// 由圆心和半径定义的圆。
pub struct Circle {
  center : Point2D
  radius : Double
} derive(Debug)

///|
pub extend Circle with @moonbitlang/core/debug.Debug::{to_repr}

///|
pub extend Circle with Measurable::{area}

///|
pub extend Circle with PerimeterMeasurable::{perimeter}

///|
pub extend Circle with Containable::{contains}

///|
/// Construct a circle.
/// 构造圆。
pub fn Circle::new(center : Point2D, radius : Double) -> Circle {
  { center, radius, }
}

///|
/// Area of the circle.
/// 圆面积。
pub impl Measurable for Circle with fn area(self) {
  @math.PI * self.radius * self.radius
}

///|
/// Perimeter (circumference) of the circle.
/// 圆周长。
pub impl PerimeterMeasurable for Circle with fn perimeter(self) {
  2.0 * @math.PI * self.radius
}

///|
/// Whether a point lies inside or on the circle.
/// 点是否在圆内或圆上。
pub impl Containable for Circle with fn contains(self, p) {
  self.center.dist_sq(p) <= self.radius * self.radius
}

///|
/// An axis-aligned bounding box (AABB) rectangle.
/// 轴对齐包围盒（AABB）矩形。
pub struct Rectangle {
  min_x : Double
  min_y : Double
  max_x : Double
  max_y : Double
} derive(Debug)

///|
pub extend Rectangle with @moonbitlang/core/debug.Debug::{to_repr}

///|
pub extend Rectangle with Measurable::{area}

///|
pub extend Rectangle with PerimeterMeasurable::{perimeter}

///|
pub extend Rectangle with Containable::{contains}

///|
/// Construct a rectangle from corner coordinates.
/// 从角坐标构造矩形。
pub fn Rectangle::new(
  min_x : Double,
  min_y : Double,
  max_x : Double,
  max_y : Double,
) -> Rectangle {
  { min_x, min_y, max_x, max_y, }
}

///|
/// Construct a rectangle from two opposite corners.
/// 从两个对角构造矩形。
pub fn Rectangle::from_corners(p1 : Point2D, p2 : Point2D) -> Rectangle {
  {
    min_x: if p1.x < p2.x {
      p1.x
    } else {
      p2.x
    },
    min_y: if p1.y < p2.y {
      p1.y
    } else {
      p2.y
    },
    max_x: if p1.x > p2.x {
      p1.x
    } else {
      p2.x
    },
    max_y: if p1.y > p2.y {
      p1.y
    } else {
      p2.y
    },
  }
}

///|
/// Area of the rectangle.
/// 矩形面积。
pub impl Measurable for Rectangle with fn area(self) {
  (self.max_x - self.min_x) * (self.max_y - self.min_y)
}

///|
/// Perimeter of the rectangle.
/// 矩形周长。
pub impl PerimeterMeasurable for Rectangle with fn perimeter(self) {
  2.0 * (self.max_x - self.min_x + (self.max_y - self.min_y))
}

///|
/// Width of the rectangle.
/// 矩形宽度。
pub fn Rectangle::width(self : Rectangle) -> Double {
  self.max_x - self.min_x
}

///|
/// Height of the rectangle.
/// 矩形高度。
pub fn Rectangle::height(self : Rectangle) -> Double {
  self.max_y - self.min_y
}

///|
/// Whether a point lies inside or on the rectangle.
/// 点是否在矩形内或矩形上。
pub impl Containable for Rectangle with fn contains(self, p) {
  p.x >= self.min_x &&
  p.x <= self.max_x &&
  p.y >= self.min_y &&
  p.y <= self.max_y
}

///|
/// Union (smallest enclosing AABB) of two rectangles.
/// 两矩形的并集（最小包围 AABB）。
pub fn Rectangle::union(self : Rectangle, other : Rectangle) -> Rectangle {
  {
    min_x: if self.min_x < other.min_x {
      self.min_x
    } else {
      other.min_x
    },
    min_y: if self.min_y < other.min_y {
      self.min_y
    } else {
      other.min_y
    },
    max_x: if self.max_x > other.max_x {
      self.max_x
    } else {
      other.max_x
    },
    max_y: if self.max_y > other.max_y {
      self.max_y
    } else {
      other.max_y
    },
  }
}

///|
/// Intersection of two rectangles. Returns None if they do not overlap.
/// 两矩形交集。不重叠时返回 None。
pub fn Rectangle::intersection(
  self : Rectangle,
  other : Rectangle,
) -> Rectangle? {
  let min_x = if self.min_x > other.min_x { self.min_x } else { other.min_x }
  let min_y = if self.min_y > other.min_y { self.min_y } else { other.min_y }
  let max_x = if self.max_x < other.max_x { self.max_x } else { other.max_x }
  let max_y = if self.max_y < other.max_y { self.max_y } else { other.max_y }
  if min_x > max_x || min_y > max_y {
    None
  } else {
    Some({ min_x, min_y, max_x, max_y, })
  }
}

///|
pub extend Orientation with @moonbitlang/core/debug.Debug::{to_repr}

///|
pub extend Orientation with Eq::{not_equal, equal}

///|
pub extend Polygon with @moonbitlang/core/debug.Debug::{to_repr}
