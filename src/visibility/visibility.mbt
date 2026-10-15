///|
/// Check if two points are mutually visible inside a polygon (segment doesn't cross edges). / 检查多边形内两点是否互相可见（线段不穿越边）。
pub fn is_visible(
  poly : Array[@core.Point2D],
  from : @core.Point2D,
  to : @core.Point2D,
) -> Bool {
  let n = poly.length()
  if n < 3 {
    return false
  }
  let eps = 0.000000000001
  for i in 0..<n {
    let j = (i + 1) % n
    let p1 = poly[i]
    let p2 = poly[j]
    let d1x = to.x() - from.x()
    let d1y = to.y() - from.y()
    let d2x = p2.x() - p1.x()
    let d2y = p2.y() - p1.y()
    let denom = d1x * d2y - d1y * d2x
    if denom.abs() < eps {
      continue
    }
    let t = ((p1.x() - from.x()) * d2y - (p1.y() - from.y()) * d2x) / denom
    let s = ((p1.x() - from.x()) * d1y - (p1.y() - from.y()) * d1x) / denom
    if t > eps && t < 1.0 - eps && s > eps && s < 1.0 - eps {
      return false
    }
  }
  true
}

///|
/// Compute visibility polygon from a point inside a convex polygon. / 计算凸多边形内一点的可见多边形。
pub fn visibility_polygon_convex(
  poly : Array[@core.Point2D],
  pt : @core.Point2D,
) -> Array[@core.Point2D] {
  let n = poly.length()
  if n < 3 {
    return []
  }
  let result : Array[@core.Point2D] = []
  for i in 0..<n {
    if is_visible(poly, pt, poly[i]) {
      result.push(poly[i])
    }
  }
  result
}

///|
/// Compute visibility polygon from a point (general algorithm for simple polygons). / 计算一点的可见多边形（简单多边形通用算法）。
pub fn visibility_polygon(
  poly : Array[@core.Point2D],
  pt : @core.Point2D,
) -> Array[@core.Point2D] {
  let n = poly.length()
  if n < 3 {
    return []
  }
  let visible : Array[@core.Point2D] = []
  for i in 0..<n {
    let curr = poly[i]
    if is_visible(poly, pt, curr) {
      visible.push(curr)
      continue
    }
    let prev = poly[(i - 1 + n) % n]
    let next = poly[(i + 1) % n]
    let dx_prev = prev.x() - curr.x()
    let dy_prev = prev.y() - curr.y()
    let dx_next = next.x() - curr.x()
    let dy_next = next.y() - curr.y()
    let dx_pt = pt.x() - curr.x()
    let dy_pt = pt.y() - curr.y()
    let cross1 = dx_prev * dy_pt - dy_prev * dx_pt
    let cross2 = dx_pt * dy_next - dy_pt * dx_next
    if cross1 * cross2 > 0.0 {
      visible.push(curr)
    }
  }
  visible
}

///|
/// Count visible vertices from a point. / 计算从一点可见的顶点数。
pub fn visible_vertex_count(
  poly : Array[@core.Point2D],
  pt : @core.Point2D,
) -> Int {
  let mut count = 0
  for v in poly {
    if is_visible(poly, pt, v) {
      count += 1
    }
  }
  count
}