///|
/// Narrow phase: point in polygon test. / 窄相：点在多边形内测试。
pub fn point_in_polygon(p : @core.Point2D, poly : Array[@core.Point2D]) -> Bool {
  let n = poly.length()
  let mut inside = false
  let mut j = n - 1
  for i in 0..<n {
    let yi = poly[i].y()
    let yj = poly[j].y()
    let xi = poly[i].x()
    let xj = poly[j].x()
    if (yi > p.y()) != (yj > p.y()) {
      let x_intersect = xi + (p.y() - yi) / (yj - yi) * (xj - xi)
      if p.x() < x_intersect {
        inside = !inside
      }
    }
    j = i
  }
  inside
}

///|
/// Narrow phase: circle-circle collision. / 窄相：圆-圆碰撞。
pub fn circle_circle_collide(
  c1 : @core.Point2D,
  r1 : Double,
  c2 : @core.Point2D,
  r2 : Double,
) -> Bool {
  let dist_sq = c1.dist_sq(c2)
  let r_sum = r1 + r2
  dist_sq <= r_sum * r_sum
}
