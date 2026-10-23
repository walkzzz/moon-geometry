///|
/// Ensure a polygon is counter-clockwise oriented.
/// Returns a CCW vertex array. / 确保多边形为逆时针方向，返回 CCW 顶点数组。
fn ensure_ccw(poly : @core.Polygon) -> Array[@core.Point2D] {
  let n = poly.size()
  let pts : Array[@core.Point2D] = []
  for i in 0..<n {
    pts.push(poly.get(i))
  }
  if n < 3 {
    return pts
  }
  let area = @polygon.polygon_signed_area(poly)
  if area < 0.0 {
    let reversed : Array[@core.Point2D] = []
    for i in 0..<n {
      reversed.push(pts[n - 1 - i])
    }
    return reversed
  }
  pts
}

///|
/// Find the index of the bottom-most (then left-most) vertex.
/// 查找最底（然后最左）顶点的索引。
fn bottom_left_index(pts : Array[@core.Point2D]) -> Int32 {
  let n = pts.length()
  let mut best = 0
  for i in 1..<n {
    if pts[i].y() < pts[best].y() ||
      (pts[i].y() == pts[best].y() && pts[i].x() < pts[best].x()) {
      best = i
    }
  }
  best
}

///|
/// Edge angle of vertex at index i in CCW polygon.
/// Returns angle in [0, 2*PI). / CCW 多边形中顶点 i 的边角度，返回 [0, 2*PI)。
fn edge_angle(pts : Array[@core.Point2D], i : Int32) -> Double {
  let n = pts.length()
  let dx = pts[(i + 1) % n].x() - pts[i].x()
  let dy = pts[(i + 1) % n].y() - pts[i].y()
  let angle = @math.atan2(dy, dx)
  if angle < 0.0 {
    angle + 2.0 * 3.141592653589793
  } else {
    angle
  }
}

///|
/// Remove collinear vertices from a polygon vertex array.
/// 移除多边形顶点数组中的共线顶点。
fn remove_collinear(pts : Array[@core.Point2D]) -> Array[@core.Point2D] {
  let n = pts.length()
  if n < 3 {
    return pts
  }
  let result : Array[@core.Point2D] = []
  for i in 0..<n {
    let prev = pts[(i - 1 + n) % n]
    let curr = pts[i]
    let next = pts[(i + 1) % n]
    let cross = @core.turn(prev, curr, next)
    if @core.approx_eq(cross, 0.0, 0.0000000001) {
      continue
    }
    result.push(curr)
  }
  result
}

///|
/// Minkowski sum of two convex polygons.
/// Returns the result as an array of points (CCW).
/// Both inputs must be convex. / 两个凸多边形的 Minkowski 和，返回 CCW 点数组。输入必须为凸。
pub fn minkowski_sum_convex(
  poly1 : @core.Polygon,
  poly2 : @core.Polygon,
) -> Array[@core.Point2D] {
  let n1 = poly1.size()
  let n2 = poly2.size()
  if n1 == 0 || n2 == 0 {
    return []
  }
  let pts1 = ensure_ccw(poly1)
  let pts2 = ensure_ccw(poly2)
  let start1 = bottom_left_index(pts1)
  let start2 = bottom_left_index(pts2)
  let result : Array[@core.Point2D] = []
  let start = @core.Point2D::new(
    pts1[start1].x() + pts2[start2].x(),
    pts1[start1].y() + pts2[start2].y(),
  )
  result.push(start)
  let mut i = 0
  let mut j = 0
  let mut count = 0
  let total = n1 + n2
  while count < total - 1 {
    let idx1 = (start1 + i) % n1
    let idx2 = (start2 + j) % n2
    let a1 = edge_angle(pts1, idx1)
    let a2 = edge_angle(pts2, idx2)
    let (dx, dy) = if j >= n2 || (i < n1 && a1 <= a2) {
      let ddx = pts1[(idx1 + 1) % n1].x() - pts1[idx1].x()
      let ddy = pts1[(idx1 + 1) % n1].y() - pts1[idx1].y()
      i += 1
      (ddx, ddy)
    } else {
      let ddx = pts2[(idx2 + 1) % n2].x() - pts2[idx2].x()
      let ddy = pts2[(idx2 + 1) % n2].y() - pts2[idx2].y()
      j += 1
      (ddx, ddy)
    }
    let last = result[result.length() - 1]
    result.push(@core.Point2D::new(last.x() + dx, last.y() + dy))
    count += 1
  }
  if result.length() > 1 {
    ignore(result.remove(result.length() - 1))
  }
  remove_collinear(result)
}

///|
/// Minkowski difference of two convex polygons: A ⊖ B = A ⊕ (-B).
/// Returns the result as an array of points (CCW).
/// / 两个凸多边形的 Minkowski 差：A ⊖ B = A ⊕ (-B)，返回 CCW 点数组。
pub fn minkowski_difference_convex(
  poly1 : @core.Polygon,
  poly2 : @core.Polygon,
) -> Array[@core.Point2D] {
  let n2 = poly2.size()
  if n2 == 0 {
    return []
  }
  let neg_pts : Array[@core.Point2D] = []
  for i in 0..<n2 {
    let p = poly2.get(i)
    neg_pts.push(@core.Point2D::new(-p.x(), -p.y()))
  }
  let neg_poly = @core.Polygon::new(neg_pts)
  minkowski_sum_convex(poly1, neg_poly)
}

///|
/// Minkowski sum of a circle and a convex polygon (rounded polygon).
/// Returns (polygon vertices, radius) representing the rounded result.
/// / 圆与凸多边形的 Minkowski 和（圆角多边形），返回 (多边形顶点, 半径)。
pub fn minkowski_sum_circle_polygon(
  circle : @core.Circle,
  poly : @core.Polygon,
) -> (Array[@core.Point2D], Double) {
  let n = poly.size()
  if n == 0 {
    return ([], circle.radius)
  }
  let pts = ensure_ccw(poly)
  let r = circle.radius
  let cx = circle.center.x()
  let cy = circle.center.y()
  let result : Array[@core.Point2D] = []
  for i in 0..<n {
    result.push(@core.Point2D::new(pts[i].x() + cx, pts[i].y() + cy))
  }
  (result, r)
}

///|
/// Check if two convex polygons collide (intersect) using Minkowski difference.
/// They collide iff origin is inside (A ⊖ B). / 用 Minkowski 差检查两凸多边形是否碰撞。
pub fn convex_polygons_collide(
  poly1 : @core.Polygon,
  poly2 : @core.Polygon,
) -> Bool {
  let diff = minkowski_difference_convex(poly1, poly2)
  if diff.length() < 3 {
    return false
  }
  let origin = @core.Point2D::new(0.0, 0.0)
  let diff_poly = @core.Polygon::new(diff)
  @polygon.point_in_polygon(origin, diff_poly)
}
