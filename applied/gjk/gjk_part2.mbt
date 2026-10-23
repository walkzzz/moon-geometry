///|

///|
/// Support function for a convex polygon. / 凸多边形的支撑函数。
pub fn polygon_support(
  poly : Array[@core.Point2D],
  dx : Double,
  dy : Double,
) -> @core.Point2D {
  let mut best = poly[0]
  let mut best_dot = poly[0].x() * dx + poly[0].y() * dy
  for i in 1..<poly.length() {
    let dot = poly[i].x() * dx + poly[i].y() * dy
    if dot > best_dot {
      best_dot = dot
      best = poly[i]
    }
  }
  best
}

///|
/// Support function for a circle. / 圆的支撑函数。
pub fn circle_support(
  center : @core.Point2D,
  radius : Double,
  dx : Double,
  dy : Double,
) -> @core.Point2D {
  let len = (dx * dx + dy * dy).sqrt()
  if len < 0.000000000001 {
    return center
  }
  @core.Point2D::new(
    center.x() + radius * dx / len,
    center.y() + radius * dy / len,
  )
}
