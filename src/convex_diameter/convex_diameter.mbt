///|
/// Compute the diameter of a convex polygon (maximum distance between any two vertices). / 计算凸多边形的直径（任意两顶点间最大距离）。
pub fn convex_diameter(poly : @core.Polygon) -> Double {
  let n = poly.size()
  if n < 2 {
    return 0.0
  }
  let mut max_dist = 0.0
  for i in 0..<n {
    for j in (i + 1)..<n {
      let d = poly.get(i).dist(poly.get(j))
      if d > max_dist {
        max_dist = d
      }
    }
  }
  max_dist
}

///|
/// Find the antipodal pair achieving the diameter. / 找到实现直径的对踵点对。
pub fn convex_diameter_pair(
  poly : @core.Polygon,
) -> (@core.Point2D, @core.Point2D) {
  let n = poly.size()
  if n < 2 {
    let z = @core.Point2D::new(0.0, 0.0)
    return (z, z)
  }
  let mut best_i = 0
  let mut best_j = 1
  let mut max_dist = poly.get(0).dist(poly.get(1))
  for i in 0..<n {
    for j in (i + 1)..<n {
      let d = poly.get(i).dist(poly.get(j))
      if d > max_dist {
        max_dist = d
        best_i = i
        best_j = j
      }
    }
  }
  (poly.get(best_i), poly.get(best_j))
}

///|
/// Compute the radius of the minimum enclosing circle (lower bound from diameter). / 由直径计算最小包围圆半径下界。
pub fn convex_radius_lower_bound(poly : @core.Polygon) -> Double {
  convex_diameter(poly) / 2.0
}

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