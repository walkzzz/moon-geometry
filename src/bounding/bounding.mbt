///|
/// Axis-aligned bounding box of a point set.
/// 点集的轴对齐包围盒。
pub fn aabb(points : Array[@core.Point2D]) -> @core.Rectangle {
  let n = points.length()
  if n == 0 {
    return @core.Rectangle::new(0.0, 0.0, 0.0, 0.0)
  }
  let mut min_x = points[0].x
  let mut max_x = points[0].x
  let mut min_y = points[0].y
  let mut max_y = points[0].y
  for i in 1..<n {
    if points[i].x < min_x { min_x = points[i].x }
    if points[i].x > max_x { max_x = points[i].x }
    if points[i].y < min_y { min_y = points[i].y }
    if points[i].y > max_y { max_y = points[i].y }
  }
  @core.Rectangle::new(min_x, min_y, max_x, max_y)
}

///|
/// Axis-aligned bounding box of a polygon.
/// 多边形的轴对齐包围盒。
pub fn aabb_polygon(poly : @core.Polygon) -> @core.Rectangle {
  let n = poly.size()
  if n == 0 {
    return @core.Rectangle::new(0.0, 0.0, 0.0, 0.0)
  }
  let mut min_x = poly.get(0).x
  let mut max_x = poly.get(0).x
  let mut min_y = poly.get(0).y
  let mut max_y = poly.get(0).y
  for i in 1..<n {
    let v = poly.get(i)
    if v.x < min_x { min_x = v.x }
    if v.x > max_x { max_x = v.x }
    if v.y < min_y { min_y = v.y }
    if v.y > max_y { max_y = v.y }
  }
  @core.Rectangle::new(min_x, min_y, max_x, max_y)
}

///|
/// Minimum-area bounding rectangle (rotating calipers on convex hull).
/// Returns (center_x, center_y, width, height, angle).
/// 最小面积包围矩形（旋转卡壳法，基于凸包）。
/// 返回 (中心x, 中心y, 宽, 高, 角度)。
pub fn min_area_bounding_rect(
  points : Array[@core.Point2D]
) -> (Double, Double, Double, Double, Double) {
  let hull = @hull.convex_hull_andrew(points)
  let n = hull.length()
  if n < 2 {
    if n == 0 {
      return (0.0, 0.0, 0.0, 0.0, 0.0)
    }
    return (hull[0].x, hull[0].y, 0.0, 0.0, 0.0)
  }
  let mut best_area = 999999999999999.0
  let mut best_cx = 0.0
  let mut best_cy = 0.0
  let mut best_w = 0.0
  let mut best_h = 0.0
  let mut best_angle = 0.0
  for i in 0..<n {
    let j = (i + 1) % n
    let dx = hull[j].x - hull[i].x
    let dy = hull[j].y - hull[i].y
    let len = (dx * dx + dy * dy).sqrt()
    if len == 0.0 {
      continue
    }
    let cos_a = dx / len
    let sin_a = dy / len
    let mut min_u = 999999999999999.0
    let mut max_u = -999999999999999.0
    let mut min_v = 999999999999999.0
    let mut max_v = -999999999999999.0
    for k in 0..<n {
      let px = hull[k].x - hull[i].x
      let py = hull[k].y - hull[i].y
      let u = px * cos_a + py * sin_a
      let v = -px * sin_a + py * cos_a
      if u < min_u { min_u = u }
      if u > max_u { max_u = u }
      if v < min_v { min_v = v }
      if v > max_v { max_v = v }
    }
    let w = max_u - min_u
    let h = max_v - min_v
    let area = w * h
    if area < best_area {
      best_area = area
      best_w = w
      best_h = h
      best_angle = @math.atan2(sin_a, cos_a)
      best_cx = hull[i].x + (min_u + max_u) / 2.0 * cos_a - (min_v + max_v) / 2.0 * sin_a
      best_cy = hull[i].y + (min_u + max_u) / 2.0 * sin_a + (min_v + max_v) / 2.0 * cos_a
    }
  }
  (best_cx, best_cy, best_w, best_h, best_angle)
}

///|
/// Bounding circle (approximate, using centroid + max distance).
/// 包围圆（近似，使用质心 + 最大距离）。
pub fn bounding_circle(
  points : Array[@core.Point2D]
) -> (@core.Point2D, Double) {
  let n = points.length()
  if n == 0 {
    return (@core.Point2D::new(0.0, 0.0), 0.0)
  }
  let mut cx = 0.0
  let mut cy = 0.0
  for p in points {
    cx += p.x
    cy += p.y
  }
  cx = cx / n.to_double()
  cy = cy / n.to_double()
  let center = @core.Point2D::new(cx, cy)
  let mut max_r = 0.0
  for p in points {
    let d = p.dist(center)
    if d > max_r { max_r = d }
  }
  (center, max_r)
}