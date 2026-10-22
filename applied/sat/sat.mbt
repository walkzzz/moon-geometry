///|
/// # SAT Collision Detection
/// # SAT 碰撞检测
///
/// Separating Axis Theorem for convex polygon collision detection.
/// 分离轴定理检测凸多边形碰撞。
///
/// ## Complexity: O(n + m) where n, m are vertex counts
/// ## 复杂度: O(n + m)，n, m 为顶点数

///|
/// SAT collision result. / SAT 碰撞结果。
pub struct SATResult {
  collides : Bool
  overlap : Double
  axis_x : Double
  axis_y : Double
}

///|
/// Construct a SAT result. / 构造 SAT 结果。
pub fn SATResult::new(
  collides : Bool,
  overlap : Double,
  axis_x : Double,
  axis_y : Double,
) -> SATResult {
  { collides, overlap, axis_x, axis_y }
}

///|
/// Check collision between two convex polygons using SAT. / 使用 SAT 检测两凸多边形碰撞。
///
/// Returns the collision result with minimum overlap and separating axis.
/// 返回碰撞结果（含最小重叠和分离轴）。
pub fn sat_collide_polygons(
  poly1 : Array[@core.Point2D],
  poly2 : Array[@core.Point2D],
) -> SATResult {
  let axes1 = get_edge_axes(poly1)
  let axes2 = get_edge_axes(poly2)
  let mut min_overlap = 1000000000000.0
  let mut sep_x = 0.0
  let mut sep_y = 0.0
  for i in 0..<axes1.length() {
    let (ax, ay) = axes1[i]
    let (min1, max1) = project_polygon(poly1, ax, ay)
    let (min2, max2) = project_polygon(poly2, ax, ay)
    let overlap = interval_overlap(min1, max1, min2, max2)
    if overlap <= 0.0 {
      return SATResult::new(false, 0.0, ax, ay)
    }
    if overlap < min_overlap {
      min_overlap = overlap
      sep_x = ax
      sep_y = ay
    }
  }
  for i in 0..<axes2.length() {
    let (ax, ay) = axes2[i]
    let (min1, max1) = project_polygon(poly1, ax, ay)
    let (min2, max2) = project_polygon(poly2, ax, ay)
    let overlap = interval_overlap(min1, max1, min2, max2)
    if overlap <= 0.0 {
      return SATResult::new(false, 0.0, ax, ay)
    }
    if overlap < min_overlap {
      min_overlap = overlap
      sep_x = ax
      sep_y = ay
    }
  }
  SATResult::new(true, min_overlap, sep_x, sep_y)
}

fn get_edge_axes(poly : Array[@core.Point2D]) -> Array[(Double, Double)] {
  let axes : Array[(Double, Double)] = []
  let n = poly.length()
  for i in 0..<n {
    let cur = poly[i]
    let nxt = poly[(i + 1) % n]
    let dx = nxt.x() - cur.x()
    let dy = nxt.y() - cur.y()
    let len = (dx * dx + dy * dy).sqrt()
    if len > 0.000000000001 {
      axes.push((dy / len, -dx / len))
    }
  }
  axes
}

fn project_polygon(
  poly : Array[@core.Point2D],
  ax : Double,
  ay : Double,
) -> (Double, Double) {
  let mut min_val = poly[0].x() * ax + poly[0].y() * ay
  let mut max_val = min_val
  for i in 1..<poly.length() {
    let proj = poly[i].x() * ax + poly[i].y() * ay
    if proj < min_val {
      min_val = proj
    }
    if proj > max_val {
      max_val = proj
    }
  }
  (min_val, max_val)
}

fn interval_overlap(
  min1 : Double,
  max1 : Double,
  min2 : Double,
  max2 : Double,
) -> Double {
  if max1 < min2 || max2 < min1 {
    return 0.0
  }
  if max1 > max2 {
    max2 - min1
  } else {
    max1 - min2
  }
}

///|
/// Check if a convex polygon contains a point using SAT. / 使用 SAT 检测凸多边形是否包含点。
pub fn sat_contains_point(
  poly : Array[@core.Point2D],
  p : @core.Point2D,
) -> Bool {
  let axes = get_edge_axes(poly)
  for i in 0..<axes.length() {
    let (ax, ay) = axes[i]
    let (min_val, max_val) = project_polygon(poly, ax, ay)
    let proj = p.x() * ax + p.y() * ay
    if proj < min_val || proj > max_val {
      return false
    }
  }
  true
}

///|
/// Check collision between two circles using SAT. / 使用 SAT 检测两圆碰撞。
pub fn sat_collide_circles(
  c1 : @core.Point2D,
  r1 : Double,
  c2 : @core.Point2D,
  r2 : Double,
) -> SATResult {
  let dx = c2.x() - c1.x()
  let dy = c2.y() - c1.y()
  let dist = (dx * dx + dy * dy).sqrt()
  let r_sum = r1 + r2
  if dist > r_sum {
    let ax = if dist > 0.000000000001 {
      dx / dist
    } else {
      1.0
    }
    let ay = if dist > 0.000000000001 {
      dy / dist
    } else {
      0.0
    }
    return SATResult::new(false, 0.0, ax, ay)
  }
  let ax = if dist > 0.000000000001 {
    dx / dist
  } else {
    1.0
  }
  let ay = if dist > 0.000000000001 {
    dy / dist
  } else {
    0.0
  }
  SATResult::new(true, r_sum - dist, ax, ay)
}

///|
/// Check collision between a convex polygon and a circle using SAT. / 使用 SAT 检测凸多边形与圆碰撞。
pub fn sat_collide_polygon_circle(
  poly : Array[@core.Point2D],
  center : @core.Point2D,
  radius : Double,
) -> SATResult {
  let axes = get_edge_axes(poly)
  let n = poly.length()
  let mut min_overlap = 1000000000000.0
  let mut sep_x = 0.0
  let mut sep_y = 0.0
  for i in 0..<axes.length() {
    let (ax, ay) = axes[i]
    let (min_val, max_val) = project_polygon(poly, ax, ay)
    let center_proj = center.x() * ax + center.y() * ay
    let circle_min = center_proj - radius
    let circle_max = center_proj + radius
    let overlap = interval_overlap(min_val, max_val, circle_min, circle_max)
    if overlap <= 0.0 {
      return SATResult::new(false, 0.0, ax, ay)
    }
    if overlap < min_overlap {
      min_overlap = overlap
      sep_x = ax
      sep_y = ay
    }
  }
  for i in 0..<n {
    let dx = center.x() - poly[i].x()
    let dy = center.y() - poly[i].y()
    let dist = (dx * dx + dy * dy).sqrt()
    if dist < 0.000000000001 {
      continue
    }
    let ax = dx / dist
    let ay = dy / dist
    let (min_val, max_val) = project_polygon(poly, ax, ay)
    let center_proj = center.x() * ax + center.y() * ay
    let circle_min = center_proj - radius
    let circle_max = center_proj + radius
    let overlap = interval_overlap(min_val, max_val, circle_min, circle_max)
    if overlap <= 0.0 {
      return SATResult::new(false, 0.0, ax, ay)
    }
    if overlap < min_overlap {
      min_overlap = overlap
      sep_x = ax
      sep_y = ay
    }
  }
  SATResult::new(true, min_overlap, sep_x, sep_y)
}

///|
/// Get the minimum translation vector (MTV) from a SAT result. / 从 SAT 结果获取最小平移向量。
pub fn sat_mtv(result : SATResult) -> @core.Point2D {
  @core.Point2D::new(result.axis_x * result.overlap, result.axis_y * result.overlap)
}

///|
/// Get the separating axis direction from a SAT result. / 从 SAT 结果获取分离轴方向。
pub fn sat_separating_axis(result : SATResult) -> @core.Point2D {
  @core.Point2D::new(result.axis_x, result.axis_y)
}