///|
/// Check if a set of guards covers all vertices of a polygon. / 检查守卫集合是否覆盖多边形所有顶点。
pub fn art_gallery_covers_vertices(
  poly : Array[@core.Point2D],
  guards : Array[@core.Point2D],
) -> Bool {
  let n = poly.length()
  if n < 3 || guards.length() == 0 {
    return false
  }
  for v in poly {
    let mut found = false
    for g in guards {
      if g.dist(v) < 0.000000000001 {
        found = true
        break
      }
    }
    if !found {
      return false
    }
  }
  true
}
