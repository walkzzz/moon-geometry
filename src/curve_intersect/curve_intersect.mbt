///|
/// Check if two line segments intersect. / 检查两条线段是否相交。
pub fn segments_cross(
  p1 : @core.Point2D,
  p2 : @core.Point2D,
  p3 : @core.Point2D,
  p4 : @core.Point2D,
) -> Bool {
  let eps = 0.000000000001
  let d1x = p2.x() - p1.x()
  let d1y = p2.y() - p1.y()
  let d2x = p4.x() - p3.x()
  let d2y = p4.y() - p3.y()
  let denom = d1x * d2y - d1y * d2x
  if denom.abs() < eps {
    return false
  }
  let t = ((p3.x() - p1.x()) * d2y - (p3.y() - p1.y()) * d2x) / denom
  let s = ((p3.x() - p1.x()) * d1y - (p3.y() - p1.y()) * d1x) / denom
  t > eps && t < 1.0 - eps && s > eps && s < 1.0 - eps
}

///|
/// Check if a polyline self-intersects. / 检查折线是否自相交。
pub fn curve_self_intersect(
  points : Array[@core.Point2D],
) -> Bool {
  let n = points.length()
  if n < 4 {
    return false
  }
  for i in 0..<(n - 1) {
    for j in (i + 2)..<(n - 1) {
      if segments_cross(points[i], points[i + 1], points[j], points[j + 1]) {
        return true
      }
    }
  }
  false
}

///|
/// Count self-intersections of a polyline. / 计数折线自相交次数。
pub fn curve_self_intersect_count(
  points : Array[@core.Point2D],
) -> Int {
  let n = points.length()
  if n < 4 {
    return 0
  }
  let mut count = 0
  for i in 0..<(n - 1) {
    for j in (i + 2)..<(n - 1) {
      if segments_cross(points[i], points[i + 1], points[j], points[j + 1]) {
        count += 1
      }
    }
  }
  count
}

///|
/// Check if two polylines intersect. / 检查两条折线是否相交。
pub fn curves_intersect(
  c1 : Array[@core.Point2D],
  c2 : Array[@core.Point2D],
) -> Bool {
  let n1 = c1.length()
  let n2 = c2.length()
  if n1 < 2 || n2 < 2 {
    return false
  }
  for i in 0..<(n1 - 1) {
    for j in 0..<(n2 - 1) {
      if segments_cross(c1[i], c1[i + 1], c2[j], c2[j + 1]) {
        return true
      }
    }
  }
  false
}