/// |
/// # Polygon Corner Rounding
/// # 多边形圆角化
///
/// Round the corners of a polygon by replacing each vertex with a short arc.
/// 通过用短弧替换每个顶点来圆角化多边形。
///
/// ## Complexity: O(n × k) where k = arc segments per corner
/// ## 复杂度: O(n × k)，k = 每个角的弧段数

/// |
/// Round all corners of a polygon with given radius.
/// 用给定半径圆角化多边形所有角。
///
/// # Arguments / 参数
/// - `pts`: polygon vertices / 多边形顶点
/// - `radius`: rounding radius / 圆角半径
/// - `segments`: arc segments per corner / 每个角的弧段数
pub fn round_polygon(
  pts : Array[@core.Point2D],
  radius : Double,
  segments : Int,
) -> Array[@core.Point2D] {
  let n = pts.length()
  let result : Array[@core.Point2D] = []
  if n < 3 || radius <= 0.0 || segments < 1 {
    return pts.copy()
  }
  for i in 0..<n {
    let prev = pts[(i - 1 + n) % n]
    let cur = pts[i]
    let next = pts[(i + 1) % n]
    let corner = round_corner(prev, cur, next, radius, segments)
    for j in 0..<corner.length() {
      result.push(corner[j])
    }
  }
  result
}

/// |
/// Round a single corner defined by three points.
/// 圆角化由三点定义的单个角。
///
/// # Arguments / 参数
/// - `p1`: previous point / 前一个点
/// - `p2`: corner point / 角点
/// - `p3`: next point / 下一个点
/// - `radius`: rounding radius / 圆角半径
/// - `segments`: arc segments / 弧段数
pub fn round_corner(
  p1 : @core.Point2D,
  p2 : @core.Point2D,
  p3 : @core.Point2D,
  radius : Double,
  segments : Int,
) -> Array[@core.Point2D] {
  let result : Array[@core.Point2D] = []
  let dx1 = p2.x() - p1.x()
  let dy1 = p2.y() - p1.y()
  let dx2 = p3.x() - p2.x()
  let dy2 = p3.y() - p2.y()
  let l1 = (dx1 * dx1 + dy1 * dy1).sqrt()
  let l2 = (dx2 * dx2 + dy2 * dy2).sqrt()
  if l1 < 0.0000001 || l2 < 0.0000001 {
    result.push(p2)
    return result
  }
  let nx1 = dx1 / l1
  let ny1 = dy1 / l1
  let nx2 = dx2 / l2
  let ny2 = dy2 / l2
  let dot = nx1 * nx2 + ny1 * ny2
  let mut angle = 0.0
  if dot >= 1.0 {
    result.push(p2)
    return result
  } else if dot <= -1.0 {
    angle = 3.141592653589793
  } else {
    angle = @math.acos(dot)
  }
  if angle < 0.0000001 {
    result.push(p2)
    return result
  }
  let half_angle = angle / 2.0
  let tan_half = @math.tan(half_angle)
  let mut r = radius
  let max_r1 = l1 * tan_half
  let max_r2 = l2 * tan_half
  let max_r = if max_r1 < max_r2 { max_r1 } else { max_r2 }
  if r > max_r {
    r = max_r
  }
  let dist = r / tan_half
  let t1 = (l1 - dist) / l1
  let t2 = dist / l2
  let start = @core.Point2D::new(p2.x() - nx1 * dist, p2.y() - ny1 * dist)
  let end = @core.Point2D::new(p2.x() + nx2 * dist, p2.y() + ny2 * dist)
  let bisect_x = (start.x() + end.x()) / 2.0 - p2.x()
  let bisect_y = (start.y() + end.y()) / 2.0 - p2.y()
  let bisect_len = (bisect_x * bisect_x + bisect_y * bisect_y).sqrt()
  let center_dist = r / @math.sin(angle / 2.0)
  let cx = if bisect_len > 0.0000001 {
    p2.x() + bisect_x / bisect_len * center_dist
  } else {
    p2.x()
  }
  let cy = if bisect_len > 0.0000001 {
    p2.y() + bisect_y / bisect_len * center_dist
  } else {
    p2.y()
  }
  let start_angle = @math.atan2(start.y() - cy, start.x() - cx)
  let end_angle = @math.atan2(end.y() - cy, end.x() - cx)
  let mut delta = end_angle - start_angle
  if delta > 3.141592653589793 {
    delta -= 6.283185307179586
  }
  if delta < -3.141592653589793 {
    delta += 6.283185307179586
  }
  for s in 0..=segments {
    let t = s.to_double() / segments.to_double()
    let a = start_angle + delta * t
    result.push(@core.Point2D::new(cx + r * @math.cos(a), cy + r * @math.sin(a)))
  }
  let _ = t1
  let _ = t2
  result
}