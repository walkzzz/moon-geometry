///|
/// Compute all antipodal pairs of a convex polygon. / 计算凸多边形的所有对踵点对。
pub fn antipodal_pairs(
  poly : @core.Polygon,
) -> Array[(Int, Int)] {
  let n = poly.size()
  let pairs : Array[(Int, Int)] = []
  if n < 3 {
    return pairs
  }
  let mut j = 1
  for i in 0..<n {
    let next_i = (i + 1) % n
    while true {
      let next_j = (j + 1) % n
      let area1 = cross_area(poly.get(i), poly.get(next_i), poly.get(j))
      let area2 = cross_area(poly.get(i), poly.get(next_i), poly.get(next_j))
      if area2 > area1 {
        j = next_j
      } else {
        break
      }
    }
    pairs.push((i, j))
  }
  pairs
}

fn cross_area(
  o : @core.Point2D,
  a : @core.Point2D,
  b : @core.Point2D,
) -> Double {
  (a.x() - o.x()) * (b.y() - o.y()) - (a.y() - o.y()) * (b.x() - o.x())
}