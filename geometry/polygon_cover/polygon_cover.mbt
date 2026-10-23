///|
/// Cover a polygon with axis-aligned rectangles (AABB-based cover). / 用轴对齐矩形覆盖多边形。
pub fn cover_by_rectangles(
  poly : Array[@core.Point2D],
) -> Array[@core.Rectangle] {
  let n = poly.length()
  if n < 3 {
    return []
  }
  let mut min_x = poly[0].x()
  let mut max_x = poly[0].x()
  let mut min_y = poly[0].y()
  let mut max_y = poly[0].y()
  for p in poly {
    if p.x() < min_x {
      min_x = p.x()
    }
    if p.x() > max_x {
      max_x = p.x()
    }
    if p.y() < min_y {
      min_y = p.y()
    }
    if p.y() > max_y {
      max_y = p.y()
    }
  }
  [@core.Rectangle::new(min_x, min_y, max_x, max_y)]
}

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

///|
/// Count rectangles in cover. / 覆盖中矩形数量。
pub fn cover_count_rectangles(poly : Array[@core.Point2D]) -> Int32 {
  cover_by_rectangles(poly).length()
}

///|
/// Count triangles in cover. / 覆盖中三角形数量。
pub fn cover_count_triangles(poly : Array[@core.Point2D]) -> Int32 {
  cover_by_triangles(poly).length()
}
