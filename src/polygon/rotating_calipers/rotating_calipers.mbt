///|
/// Cross product of vectors (b-a) and (c-a).
/// 向量 (b-a) 和 (c-a) 的叉积。
///|
/// Distance from point p to line through a and b.
/// 点 p 到直线 ab 的距离。
fn point_line_dist(
  p : @core.Point2D,
  a : @core.Point2D,
  b : @core.Point2D,
) -> Double {
  let dx = b.x() - a.x()
  let dy = b.y() - a.y()
  let len = (dx * dx + dy * dy).sqrt()
  if len < @core.default_eps {
    return 0.0
  }
  let cross_val = dx * (p.y() - a.y()) - dy * (p.x() - a.x())
  cross_val.abs() / len
}

///|
/// Convex polygon diameter: the farthest pair of vertices.
/// Returns (point_a, point_b, distance).
/// Uses rotating calipers on the convex hull, O(n).
///
/// 凸多边形直径：最远顶点对。返回 (点a, 点b, 距离)。
/// 在凸包上使用旋转卡壳，O(n)。
pub fn convex_polygon_diameter(
  poly : @core.Polygon,
) -> (@core.Point2D, @core.Point2D, Double) {
  let n = poly.size()
  if n == 0 {
    return (@core.Point2D::new(0.0, 0.0), @core.Point2D::new(0.0, 0.0), 0.0)
  }
  if n == 1 {
    let p = poly.get(0)
    return (p, p, 0.0)
  }
  let pts : Array[@core.Point2D] = []
  for i in 0..<n {
    pts.push(poly.get(i))
  }
  let mut j = 1
  let mut best_dist = 0.0
  let mut best_i = 0
  let mut best_j = 0
  for i in 0..<n {
    let ni = (i + 1) % n
    let mut d = pts[i].dist_sq(pts[j])
    if d > best_dist {
      best_dist = d
      best_i = i
      best_j = j
    }
    while true {
      let nj = (j + 1) % n
      let d2 = pts[i].dist_sq(pts[nj])
      let cross_val = @core.turn(pts[i], pts[ni], pts[nj])
      if d2 >= d && cross_val > 0.0 {
        j = nj
        d = d2
        if d > best_dist {
          best_dist = d
          best_i = i
          best_j = j
        }
      } else {
        break
      }
    }
  }
  (pts[best_i], pts[best_j], best_dist.sqrt())
}

///|
/// Convex polygon width: the minimum distance between parallel
/// supporting lines. Uses rotating calipers, O(n).
///
/// 凸多边形宽度：平行支撑线间的最小距离。旋转卡壳 O(n)。
pub fn convex_polygon_width(poly : @core.Polygon) -> Double {
  let n = poly.size()
  if n < 2 {
    return 0.0
  }
  let pts : Array[@core.Point2D] = []
  for i in 0..<n {
    pts.push(poly.get(i))
  }
  let mut j = 1
  let mut best_width = 999999999999999.0
  for i in 0..<n {
    let ni = (i + 1) % n
    while true {
      let nj = (j + 1) % n
      let cross_val = @core.turn(pts[i], pts[ni], pts[nj])
      if cross_val > 0.0 {
        j = nj
      } else {
        break
      }
    }
    let w = point_line_dist(pts[j], pts[i], pts[ni])
    if w < best_width {
      best_width = w
    }
  }
  best_width
}

///|
/// Farthest point pair from a set of points.
/// Computes convex hull first, then rotating calipers.
/// Returns None if fewer than 2 points.
///
/// 点集最远点对。先求凸包再旋转卡壳。少于 2 点返回 None。
pub fn farthest_point_pair(
  points : Array[@core.Point2D],
) -> (@core.Point2D, @core.Point2D, Double)? {
  if points.length() < 2 {
    return None
  }
  let hull_pts = @hull.convex_hull_andrew(points)
  if hull_pts.length() < 2 {
    return None
  }
  let hull_poly = @core.Polygon::new(hull_pts)
  Some(convex_polygon_diameter(hull_poly))
}

///|
/// Minimum perimeter bounding rectangle of a convex polygon.
/// Uses rotating calipers, O(n). Returns (cx, cy, width, height, angle).
///
/// 凸多边形最小周长包围矩形。旋转卡壳 O(n)。返回 (cx, cy, 宽, 高, 角度)。
pub fn min_perimeter_bounding_rect(
  poly : @core.Polygon,
) -> (Double, Double, Double, Double, Double) {
  let n = poly.size()
  if n < 3 {
    return (0.0, 0.0, 0.0, 0.0, 0.0)
  }
  let pts : Array[@core.Point2D] = []
  for i in 0..<n {
    pts.push(poly.get(i))
  }
  let mut j = 1
  let mut best_perim = 999999999999999.0
  let mut best_cx = 0.0
  let mut best_cy = 0.0
  let mut best_w = 0.0
  let mut best_h = 0.0
  let mut best_angle = 0.0
  for i in 0..<n {
    let ni = (i + 1) % n
    let dx = pts[ni].x() - pts[i].x()
    let dy = pts[ni].y() - pts[i].y()
    let edge_len = (dx * dx + dy * dy).sqrt()
    if edge_len < @core.default_eps {
      continue
    }
    while true {
      let nj = (j + 1) % n
      let cross_val = @core.turn(pts[i], pts[ni], pts[nj])
      if cross_val > 0.0 {
        j = nj
      } else {
        break
      }
    }
    let ex = dx / edge_len
    let ey = dy / edge_len
    let nx = -ey
    let ny = ex
    let mut min_p = pts[i].x() * ex + pts[i].y() * ey
    let mut max_p = min_p
    let mut min_q = pts[i].x() * nx + pts[i].y() * ny
    let mut max_q = min_q
    for k in 0..<n {
      let pp = pts[k].x() * ex + pts[k].y() * ey
      let qq = pts[k].x() * nx + pts[k].y() * ny
      if pp < min_p {
        min_p = pp
      }
      if pp > max_p {
        max_p = pp
      }
      if qq < min_q {
        min_q = qq
      }
      if qq > max_q {
        max_q = qq
      }
    }
    let w = max_p - min_p
    let h = max_q - min_q
    let perim = 2.0 * (w + h)
    if perim < best_perim {
      best_perim = perim
      best_w = w
      best_h = h
      best_cx = (min_p + max_p) / 2.0 * ex + (min_q + max_q) / 2.0 * nx
      best_cy = (min_p + max_p) / 2.0 * ey + (min_q + max_q) / 2.0 * ny
      best_angle = @math.atan2(ey, ex)
    }
  }
  (best_cx, best_cy, best_w, best_h, best_angle)
}
