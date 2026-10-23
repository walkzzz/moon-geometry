///|
/// Compute the radius of the largest inscribed circle at the Chebyshev center. / 计算切比雪夫中心处最大内切圆半径。
pub fn inradius(poly : @core.Polygon) -> Double {
  let n = poly.size()
  if n < 3 {
    return 0.0
  }
  let c = chebyshev_center(poly)
  let mut min_dist = 999999.0
  for i in 0..<n {
    let j = (i + 1) % n
    let p1 = poly.get(i)
    let p2 = poly.get(j)
    let dx = p2.x() - p1.x()
    let dy = p2.y() - p1.y()
    let len = (dx * dx + dy * dy).sqrt()
    if len < 0.000000001 {
      continue
    }
    let dist = ((c.x() - p1.x()) * dy - (c.y() - p1.y()) * dx).abs() / len
    min_dist = min_dist.min(dist)
  }
  min_dist
}