///|
/// Cover a polygon with axis-aligned rectangles (AABB-based cover). / 用轴对齐矩形覆盖多边形。
pub fn cover_by_rectangles(
  poly : Array[@core.Point2D],
) -> Array[@core.Rectangle] {
  let n = poly.length()
  if n < 3 {
    return []
  }
  let mut min_x = poly[0].x()
  let mut max_x = poly[0].x()
  let mut min_y = poly[0].y()
  let mut max_y = poly[0].y()
  for p in poly {
    if p.x() < min_x {
      min_x = p.x()
    }
    if p.x() > max_x {
      max_x = p.x()
    }
    if p.y() < min_y {
      min_y = p.y()
    }
    if p.y() > max_y {
      max_y = p.y()
    }
  }
  [@core.Rectangle::new(min_x, min_y, max_x, max_y)]
}
