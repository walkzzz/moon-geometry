///|
/// Support function: max of dot(p, dir) over all vertices p.
/// Returns the maximum projection value. O(n).
///
/// 支持函数：所有顶点在方向 dir 上的最大投影值。O(n)。
pub fn support_function(poly : @core.Polygon, dir : @core.Point2D) -> Double {
  let n = poly.size()
  if n == 0 {
    return 0.0
  }
  let mut best = poly.get(0).x() * dir.x() + poly.get(0).y() * dir.y()
  for i in 1..<n {
    let val = poly.get(i).x() * dir.x() + poly.get(i).y() * dir.y()
    if val > best {
      best = val
    }
  }
  best
}

///|
/// Extreme point: vertex with maximum projection onto direction.
/// Returns the vertex index. O(n).
///
/// 极点：在方向 dir 上投影最大的顶点。返回顶点索引。O(n)。
pub fn extreme_point(poly : @core.Polygon, dir : @core.Point2D) -> Int32 {
  let n = poly.size()
  if n == 0 {
    return -1
  }
  let mut best_idx = 0
  let mut best = poly.get(0).x() * dir.x() + poly.get(0).y() * dir.y()
  for i in 1..<n {
    let val = poly.get(i).x() * dir.x() + poly.get(i).y() * dir.y()
    if val > best {
      best = val
      best_idx = i
    }
  }
  best_idx
}

///|
/// O(log n) point-in-convex-polygon test.
/// Uses binary search on the fan triangulation from vertex 0.
/// Polygon must be convex and CCW.
///
/// O(log n) 凸多边形点包含检测。多边形必须为凸且 CCW。
pub fn point_in_convex_polygon(poly : @core.Polygon, p : @core.Point2D) -> Bool {
  let n = poly.size()
  if n == 0 {
    return false
  }
  if n == 1 {
    return @core.approx_eq(poly.get(0).x(), p.x(), 0.0000000001) &&
      @core.approx_eq(poly.get(0).y(), p.y(), 0.0000000001)
  }
  let p0 = poly.get(0)
  if @core.turn(p0, poly.get(1), p) < 0.0 {
    return false
  }
  if @core.turn(p0, poly.get(n - 1), p) > 0.0 {
    return false
  }
  let mut lo = 1
  let mut hi = n - 1
  while hi - lo > 1 {
    let mid = (lo + hi) / 2
    if @core.turn(p0, poly.get(mid), p) > 0.0 {
      lo = mid
    } else {
      hi = mid
    }
  }
  @core.turn(poly.get(lo), poly.get(hi), p) >= 0.0
}

///|
/// Tangent points from an external point to a convex polygon.
/// Returns (left_tangent_index, right_tangent_index).
/// Polygon must be convex and CCW. Point must be outside.
///
/// 从外部点到凸多边形的切点。返回 (左切线索引, 右切线索引)。
pub fn tangent_from_point(
  poly : @core.Polygon,
  p : @core.Point2D,
) -> (Int32, Int32) {
  let n = poly.size()
  if n == 0 {
    return (-1, -1)
  }
  let mut left = 0
  let mut right = 0
  for i in 1..<n {
    let prev_l = poly.get(left)
    let curr = poly.get(i)
    let cross_l = @core.turn(p, prev_l, curr)
    if cross_l > 0.0 {
      left = i
    }
    let prev_r = poly.get(right)
    let cross_r = @core.turn(p, prev_r, curr)
    if cross_r < 0.0 {
      right = i
    }
  }
  (left, right)
}

///|
/// Check if two convex polygons intersect (overlap).
/// Uses separating axis theorem: for each edge of each polygon,
/// check if it's a separating axis. O(n+m).
///
/// 检测两凸多边形是否相交（重叠）。使用分离轴定理。O(n+m)。
pub fn convex_polygons_intersect(
  poly1 : @core.Polygon,
  poly2 : @core.Polygon,
) -> Bool {
  let n1 = poly1.size()
  let n2 = poly2.size()
  if n1 == 0 || n2 == 0 {
    return false
  }
  if has_separating_axis(poly1, poly2) {
    return false
  }
  if has_separating_axis(poly2, poly1) {
    return false
  }
  true
}

///|
/// Check if any edge of poly1 is a separating axis.
/// 检查 poly1 的任一边是否为分离轴。
fn has_separating_axis(poly1 : @core.Polygon, poly2 : @core.Polygon) -> Bool {
  let n1 = poly1.size()
  for i in 0..<n1 {
    let curr = poly1.get(i)
    let next = poly1.get((i + 1) % n1)
    let dx = next.x() - curr.x()
    let dy = next.y() - curr.y()
    let nx = -dy
    let ny = dx
    let proj1 = curr.x() * nx + curr.y() * ny
    let mut min2 = poly2.get(0).x() * nx + poly2.get(0).y() * ny
    let mut max2 = min2
    let n2 = poly2.size()
    for j in 1..<n2 {
      let val = poly2.get(j).x() * nx + poly2.get(j).y() * ny
      if val < min2 {
        min2 = val
      }
      if val > max2 {
        max2 = val
      }
    }
    let mut min1 = proj1
    let mut max1 = proj1
    for j in 1..<n1 {
      let val = poly1.get(j).x() * nx + poly1.get(j).y() * ny
      if val < min1 {
        min1 = val
      }
      if val > max1 {
        max1 = val
      }
    }
    if max1 < min2 || max2 < min1 {
      return true
    }
  }
  false
}

///|
/// Minimum distance from a point to a convex polygon.
/// O(n) edge check. / 点到凸多边形最小距离。O(n)。
pub fn point_to_convex_polygon_distance(
  poly : @core.Polygon,
  p : @core.Point2D,
) -> Double {
  if point_in_convex_polygon(poly, p) {
    return 0.0
  }
  let n = poly.size()
  let mut best = 999999999999999.0
  for i in 0..<n {
    let a = poly.get(i)
    let b = poly.get((i + 1) % n)
    let seg = @core.Segment::new(a, b)
    let d = @distance.point_to_segment_distance(p, seg)
    if d < best {
      best = d
    }
  }
  best
}
