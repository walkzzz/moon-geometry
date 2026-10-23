///|
/// Compute the AABB of a polygon. / 计算多边形的 AABB。
pub fn aabb_from_polygon(poly : Array[@core.Point2D]) -> AABB {
  let mut min_x = poly[0].x()
  let mut min_y = poly[0].y()
  let mut max_x = poly[0].x()
  let mut max_y = poly[0].y()
  for i in 1..<poly.length() {
    let px = poly[i].x()
    let py = poly[i].y()
    if px < min_x {
      min_x = px
    }
    if py < min_y {
      min_y = py
    }
    if px > max_x {
      max_x = px
    }
    if py > max_y {
      max_y = py
    }
  }
  AABB::new(min_x, min_y, max_x, max_y)
}


///|
/// Collision pair result. / 碰撞对结果。
pub struct CollisionPair {
  id_a : Int
  id_b : Int
}
