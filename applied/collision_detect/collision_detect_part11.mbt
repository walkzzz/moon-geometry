///|
/// Narrow phase: circle-polygon collision. / 窄相：圆-多边形碰撞。
pub fn circle_polygon_collide(
  center : @core.Point2D,
  radius : Double,
  poly : Array[@core.Point2D],
) -> Bool {
  if point_in_polygon(center, poly) {
    return true
  }
  let n = poly.length()
  for i in 0..<n {
    let p1 = poly[i]
    let p2 = poly[(i + 1) % n]
    if point_segment_dist_sq(center, p1, p2) <= radius * radius {
      return true
    }
  }
  false
}

///|
fn point_segment_dist_sq(
  p : @core.Point2D,
  a : @core.Point2D,
  b : @core.Point2D,
) -> Double {
  let dx = b.x() - a.x()
  let dy = b.y() - a.y()
  let len_sq = dx * dx + dy * dy
  if len_sq < 0.000000000001 {
    return p.dist_sq(a)
  }
  let t = ((p.x() - a.x()) * dx + (p.y() - a.y()) * dy) / len_sq
  let tc = if t < 0.0 { 0.0 } else if t > 1.0 { 1.0 } else { t }
  let proj_x = a.x() + tc * dx
  let proj_y = a.y() + tc * dy
  (p.x() - proj_x) * (p.x() - proj_x) + (p.y() - proj_y) * (p.y() - proj_y)
}
