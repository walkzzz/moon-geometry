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
