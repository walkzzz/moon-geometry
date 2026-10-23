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
