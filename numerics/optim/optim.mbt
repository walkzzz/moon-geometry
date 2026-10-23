///|
/// Compute the smallest enclosing circle of a set of points (Welzl's algorithm, simplified). / 计算点集的最小包围圆（Welzl 算法，简化版）。
pub fn smallest_enclosing_circle(points : Array[@core.Point2D]) -> @core.Circle {
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

///|
fn circle_from_one(p : @core.Point2D) -> @core.Circle {
  @core.Circle::new(p, 0.0)
}

///|
fn circle_from_two(p1 : @core.Point2D, p2 : @core.Point2D) -> @core.Circle {
  let center = @core.Point2D::new(
    (p1.x() + p2.x()) / 2.0,
    (p1.y() + p2.y()) / 2.0,
  )
  @core.Circle::new(center, center.dist(p1))
}

///|
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
  let center = @core.Point2D::new(ux, uy)
  @core.Circle::new(center, center.dist(p1))
}

///|
fn circle_contains(c : @core.Circle, p : @core.Point2D) -> Bool {
  c.center.dist(p) <= c.radius + 0.0000001
}

///|
/// Find the minimum area rectangle enclosing a set of points. / 找到包围点集的最小面积矩形。
pub fn min_area_rect(points : Array[@core.Point2D]) -> @core.Rectangle {
  if points.length() == 0 {
    return @core.Rectangle::new(0.0, 0.0, 0.0, 0.0)
  }
  let mut min_x = points[0].x()
  let mut max_x = points[0].x()
  let mut min_y = points[0].y()
  let mut max_y = points[0].y()
  for p in points {
    min_x = min_x.min(p.x())
    max_x = max_x.max(p.x())
    min_y = min_y.min(p.y())
    max_y = max_y.max(p.y())
  }
  @core.Rectangle::new(min_x, min_y, max_x, max_y)
}

///|
/// Compute the centroid of a set of points. / 计算点集的质心。
pub fn centroid(points : Array[@core.Point2D]) -> @core.Point2D {
  if points.length() == 0 {
    return @core.Point2D::new(0.0, 0.0)
  }
  let mut sx = 0.0
  let mut sy = 0.0
  for p in points {
    sx += p.x()
    sy += p.y()
  }
  let n = points.length().to_double()
  @core.Point2D::new(sx / n, sy / n)
}

///|
/// Find the point closest to the centroid. / 找到最接近质心的点。
pub fn closest_to_centroid(points : Array[@core.Point2D]) -> @core.Point2D? {
  if points.length() == 0 {
    return None
  }
  let c = centroid(points)
  let mut best = points[0]
  let mut best_dist = c.dist(points[0])
  for p in points {
    let d = c.dist(p)
    if d < best_dist {
      best_dist = d
      best = p
    }
  }
  Some(best)
}
