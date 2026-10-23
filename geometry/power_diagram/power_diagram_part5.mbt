///|
/// Compute the regular triangulation (weighted Delaunay) of weighted sites. / 计算加权站点的正则三角剖分（加权 Delaunay）。
pub fn regular_triangulation(
  sites : Array[WeightedPoint],
) -> Array[(Int, Int, Int)] {
  let n = sites.length()
  if n < 3 {
    return []
  }
  let tris : Array[(Int, Int, Int)] = []
  for i in 0..<(n - 2) {
    for j in (i + 1)..<(n - 1) {
      for k in (j + 1)..<n {
        let is_regular = check_regular(sites, i, j, k)
        if is_regular {
          tris.push((i, j, k))
        }
      }
    }
  }
  tris
}

fn check_regular(
  sites : Array[WeightedPoint],
  i : Int,
  j : Int,
  k : Int,
) -> Bool {
  let p1 = sites[i].point
  let p2 = sites[j].point
  let p3 = sites[k].point
  let area = (p2.x() - p1.x()) * (p3.y() - p1.y()) - (p3.x() - p1.x()) * (p2.y() - p1.y())
  if area.abs() < 0.0000000001 {
    return false
  }
  let center = circumcenter2d(p1, p2, p3)
  let rsq = center.dist_sq(p1)
  let power1 = rsq - sites[i].weight
  for idx in 0..<sites.length() {
    if idx == i || idx == j || idx == k {
      continue
    }
    let pwr = center.dist_sq(sites[idx].point) - sites[idx].weight
    if pwr < power1 - 0.0000001 {
      return false
    }
  }
  true
}

fn circumcenter2d(
  a : @core.Point2D,
  b : @core.Point2D,
  c : @core.Point2D,
) -> @core.Point2D {
  let ax = a.x()
  let ay = a.y()
  let bx = b.x()
  let by = b.y()
  let cx = c.x()
  let cy = c.y()
  let d = 2.0 * (ax * (by - cy) + bx * (cy - ay) + cx * (ay - by))
  if d.abs() < 0.0000000001 {
    return @core.Point2D::new((ax + bx + cx) / 3.0, (ay + by + cy) / 3.0)
  }
  let ux = ((ax * ax + ay * ay) * (by - cy) + (bx * bx + by * by) * (cy - ay) +
    (cx * cx + cy * cy) * (ay - by)) / d
  let uy = ((ax * ax + ay * ay) * (cx - bx) + (bx * bx + by * by) * (ax - cx) +
    (cx * cx + cy * cy) * (bx - ax)) / d
  @core.Point2D::new(ux, uy)
}