///|
/// Compute the power distance from point x to weighted site (s, w): |x-s|^2 - w. / 计算点 x 到加权站点 (s, w) 的幂距离：|x-s|^2 - w。
pub fn power_distance(
  x : @core.Point2D,
  site : WeightedPoint,
) -> Double {
  x.dist_sq(site.point) - site.weight
}


///|
/// Clip a convex polygon by a power bisector half-plane. / 用幂平分线半平面裁剪凸多边形。
fn clip_by_power(
  poly : Array[@core.Point2D],
  s1 : WeightedPoint,
  s2 : WeightedPoint,
) -> Array[@core.Point2D] {
  let p1 = s1.point
  let p2 = s2.point
  let nx = p2.x() - p1.x()
  let ny = p2.y() - p1.y()
  let c = ((p2.x() * p2.x() + p2.y() * p2.y()) -
    (p1.x() * p1.x() + p1.y() * p1.y()) - s2.weight + s1.weight) / 2.0
  let result : Array[@core.Point2D] = []
  let m = poly.length()
  if m == 0 {
    return result
  }
  for i in 0..<m {
    let curr = poly[i]
    let next = poly[(i + 1) % m]
    let dc = curr.x() * nx + curr.y() * ny - c
    let dn = next.x() * nx + next.y() * ny - c
    let curr_inside = dc <= 0.0
    let next_inside = dn <= 0.0
    if curr_inside {
      result.push(curr)
    }
    if curr_inside != next_inside {
      let t = dc / (dc - dn)
      result.push(@core.Point2D::new(
        curr.x() + t * (next.x() - curr.x()),
        curr.y() + t * (next.y() - curr.y()),
      ))
    }
  }
  result
}
