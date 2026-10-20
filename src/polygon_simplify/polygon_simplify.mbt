/// |
/// # Topology-Preserving Polygon Simplification
/// # 拓扑保持的多边形简化
///
/// Simplify a polygon while preserving its topology (no self-intersections).
/// 简化多边形同时保持拓扑（无自相交）。
///
/// ## Complexity: O(n² log n)
/// ## 复杂度: O(n² log n)

/// |
/// Simplify polygon preserving topology (Douglas-Peucker + topology check).
/// 拓扑保持简化（Douglas-Peucker + 拓扑检查）。
///
/// # Arguments / 参数
/// - `pts`: polygon vertices / 多边形顶点
/// - `eps`: tolerance / 容差
pub fn simplify_topology_preserve(
  pts : Array[@core.Point2D],
  eps : Double,
) -> Array[@core.Point2D] {
  let n = pts.length()
  if n <= 3 {
    return pts.copy()
  }
  let simplified = douglas_peucker(pts, eps)
  if simplified.length() < 3 {
    return pts.copy()
  }
  if !has_self_intersection(simplified) {
    return simplified
  }
  let mut result = pts.copy()
  let mut e = eps * 0.5
  let mut iter = 0
  while iter < 20 {
    result = douglas_peucker(pts, e)
    if result.length() >= 3 && !has_self_intersection(result) {
      return result
    }
    e *= 0.5
    iter += 1
  }
  pts.copy()
}

/// |
/// Visvalingam-Whyatt simplification algorithm.
/// Visvalingam-Whyatt 简化算法。
///
/// Iteratively removes the point with the smallest effective area.
/// 迭代移除有效面积最小的点。
///
/// # Arguments / 参数
/// - `pts`: polygon vertices / 多边形顶点
/// - `target_count`: desired number of vertices / 目标顶点数
pub fn simplify_visvalingam(
  pts : Array[@core.Point2D],
  target_count : Int,
) -> Array[@core.Point2D] {
  let n = pts.length()
  if n <= target_count || target_count < 3 {
    return pts.copy()
  }
  let mut points = pts.copy()
  while points.length() > target_count {
    let m = points.length()
    let mut min_area = 1000000.0
    let mut min_idx = 1
    for i in 1..<(m - 1) {
      let area = triangle_area(points[i - 1], points[i], points[i + 1])
      if area < min_area {
        min_area = area
        min_idx = i
      }
    }
    let area_last = triangle_area(points[m - 2], points[m - 1], points[0])
    let area_first = triangle_area(points[m - 1], points[0], points[1])
    if area_last < min_area {
      min_idx = m - 1
    } else if area_first < min_area {
      min_idx = 0
    }
    let new_pts : Array[@core.Point2D] = []
    for i in 0..<m {
      if i != min_idx {
        new_pts.push(points[i])
      }
    }
    points = new_pts
  }
  points
}

/// |
/// Douglas-Peucker simplification for a closed polygon.
/// 闭合多边形的 Douglas-Peucker 简化。
pub fn douglas_peucker(
  pts : Array[@core.Point2D],
  eps : Double,
) -> Array[@core.Point2D] {
  let n = pts.length()
  if n <= 3 {
    return pts.copy()
  }
  let mut max_dist = 0.0
  let mut max_idx = 0
  for i in 1..<(n - 1) {
    let d = point_line_dist(pts[i], pts[0], pts[n - 1])
    if d > max_dist {
      max_dist = d
      max_idx = i
    }
  }
  if max_dist > eps {
    let left : Array[@core.Point2D] = []
    for i in 0..=(max_idx) {
      left.push(pts[i])
    }
    let right : Array[@core.Point2D] = []
    for i in max_idx..<(n) {
      right.push(pts[i])
    }
    let left_result = douglas_peucker(left, eps)
    let right_result = douglas_peucker(right, eps)
    let result : Array[@core.Point2D] = []
    for i in 0..<(left_result.length() - 1) {
      result.push(left_result[i])
    }
    for i in 0..<right_result.length() {
      result.push(right_result[i])
    }
    result
  } else {
    [pts[0], pts[n - 1]]
  }
}

fn point_line_dist(
  p : @core.Point2D,
  a : @core.Point2D,
  b : @core.Point2D,
) -> Double {
  let dx = b.x() - a.x()
  let dy = b.y() - a.y()
  let len = (dx * dx + dy * dy).sqrt()
  if len < 0.0000000001 {
    return ((p.x() - a.x()) * (p.x() - a.x()) + (p.y() - a.y()) * (p.y() - a.y())).sqrt()
  }
  ((dx * (a.y() - p.y()) - dy * (a.x() - p.x())).abs()) / len
}

fn triangle_area(
  a : @core.Point2D,
  b : @core.Point2D,
  c : @core.Point2D,
) -> Double {
  ((b.x() - a.x()) * (c.y() - a.y()) - (b.y() - a.y()) * (c.x() - a.x())).abs() / 2.0
}

fn has_self_intersection(pts : Array[@core.Point2D]) -> Bool {
  let n = pts.length()
  if n < 4 {
    return false
  }
  for i in 0..<n {
    let a1 = pts[i]
    let a2 = pts[(i + 1) % n]
    for j in (i + 2)..<n {
      if j == (i - 1 + n) % n {
        continue
      }
      let b1 = pts[j]
      let b2 = pts[(j + 1) % n]
      if segments_intersect(a1, a2, b1, b2) {
        return true
      }
    }
  }
  false
}

fn segments_intersect(
  a1 : @core.Point2D,
  a2 : @core.Point2D,
  b1 : @core.Point2D,
  b2 : @core.Point2D,
) -> Bool {
  let d1 = @core.turn(b1, b2, a1)
  let d2 = @core.turn(b1, b2, a2)
  let d3 = @core.turn(a1, a2, b1)
  let d4 = @core.turn(a1, a2, b2)
  if ((d1 > 0.0 && d2 < 0.0) || (d1 < 0.0 && d2 > 0.0)) &&
    ((d3 > 0.0 && d4 < 0.0) || (d3 < 0.0 && d4 > 0.0)) {
    true
  } else {
    false
  }
}

