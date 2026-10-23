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
