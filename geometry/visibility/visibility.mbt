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
