///|
/// Compute the smallest enclosing circle of a set of points (Welzl's algorithm, simplified). / 计算点集的最小包围圆（Welzl 算法，简化版）。
pub fn smallest_enclosing_circle(
  points : Array[@core.Point2D],
) -> @core.Circle {
  if points.length() == 0 {
    return @core.Circle::new(@core.Point2D::new(0.0, 0.0), 0.0)
  }
  if points.length() == 1 {
    return @core.Circle::new(points[0], 0.0)
  }
  let mut best = circle_from_two(points[0], points[1])
  for i in 0..<points.length() {
    if !circle_contains(best, points[i]) {
      best = circle_from_one(points[i])
      for j in 0..<i {
        if !circle_contains(best, points[j]) {
          best = circle_from_two(points[i], points[j])
          for k in 0..<j {
            if !circle_contains(best, points[k]) {
              best = circle_from_three(points[i], points[j], points[k])
            }
          }
        }
      }
    }
  }
  best
}

fn circle_from_one(p : @core.Point2D) -> @core.Circle {
  @core.Circle::new(p, 0.0)
}

fn circle_from_two(
  p1 : @core.Point2D,
  p2 : @core.Point2D,
) -> @core.Circle {
  let center = @core.Point2D::new(
    (p1.x() + p2.x()) / 2.0,
    (p1.y() + p2.y()) / 2.0,
  )
  @core.Circle::new(center, center.dist(p1))
}

fn circle_from_three(
  p1 : @core.Point2D,
  p2 : @core.Point2D,
  p3 : @core.Point2D,
) -> @core.Circle {
  let ax = p1.x()
  let ay = p1.y()
  let bx = p2.x()
  let by = p2.y()
  let cx = p3.x()
  let cy = p3.y()
  let d = 2.0 * (ax * (by - cy) + bx * (cy - ay) + cx * (ay - by))
  if @core.approx_eq(d, 0.0, 0.000000001) {
    return circle_from_two(p1, p2)
  }
  let ux = ((ax * ax + ay * ay) * (by - cy) + (bx * bx + by * by) * (cy - ay) + (cx * cx + cy * cy) * (ay - by)) / d
  let uy = ((ax * ax + ay * ay) * (cx - bx) + (bx * bx + by * by) * (ax - cx) + (cx * cx + cy * cy) * (bx - ax)) / d
  let center = @core.Point2D::new(ux, uy)
  @core.Circle::new(center, center.dist(p1))
}

fn circle_contains(c : @core.Circle, p : @core.Point2D) -> Bool {
  c.center.dist(p) <= c.radius + 0.0000001
}
