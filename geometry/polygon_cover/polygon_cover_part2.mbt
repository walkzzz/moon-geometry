///|
/// Cover a polygon with triangles (fan triangulation from first vertex). / 用三角形覆盖多边形（从第一个顶点的扇形三角剖分）。
pub fn cover_by_triangles(poly : Array[@core.Point2D]) -> Array[@core.Triangle] {
  let n = poly.length()
  if n < 3 {
    return []
  }
  let triangles : Array[@core.Triangle] = []
  for i in 1..<(n - 1) {
    triangles.push(@core.Triangle::new(poly[0], poly[i], poly[i + 1]))
  }
  triangles
}

///|
/// Total area of rectangle cover. / 矩形覆盖的总面积。
pub fn cover_area_rectangles(poly : Array[@core.Point2D]) -> Double {
  let rects = cover_by_rectangles(poly)
  let mut total = 0.0
  for r in rects {
    total += r.area()
  }
  total
}

///|
/// Total area of triangle cover. / 三角形覆盖的总面积。
pub fn cover_area_triangles(poly : Array[@core.Point2D]) -> Double {
  let tris = cover_by_triangles(poly)
  let mut total = 0.0
  for t in tris {
    total += t.area()
  }
  total
}
