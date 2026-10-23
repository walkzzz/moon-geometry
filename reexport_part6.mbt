///|
/// Intersection of two polygons. / 两多边形交集。
pub fn polygon_intersection(subject : Polygon, clip : Polygon) -> Polygon? {
  @boolean.polygon_intersection(subject, clip)
}


///|
/// Union area of two polygons. / 两多边形并集面积。
pub fn polygon_union_area(p1 : Polygon, p2 : Polygon) -> Double {
  @boolean.polygon_union_area(p1, p2)
}


///|
/// Difference area of two polygons. / 两多边形差集面积。
pub fn polygon_difference_area(p1 : Polygon, p2 : Polygon) -> Double {
  @boolean.polygon_difference_area(p1, p2)
}

// ---------------------------------------------------------------------------
// triangulation: Delaunay / Voronoi / 三角剖分
// ---------------------------------------------------------------------------


///|
/// Delaunay triangulation. / Delaunay 三角剖分。
pub fn delaunay_triangulation(points : Array[Point2D]) -> Array[TriangleIdx] {
  @triangulation.delaunay_triangulation(points)
}


///|
/// Voronoi diagram from Delaunay. / 由 Delaunay 构造 Voronoi 图。
pub fn voronoi_diagram(
  points : Array[Point2D],
) -> (Array[Point2D], Array[(Int, Int)]) {
  @triangulation.voronoi_diagram(points)
}

// ---------------------------------------------------------------------------
// transform: affine transforms / 仿射变换
// ---------------------------------------------------------------------------


///|
/// Translate a point. / 平移点。
pub fn translate(p : Point2D, dx : Double, dy : Double) -> Point2D {
  @transform.translate(p, dx, dy)
}


///|
/// Translate an array of points. / 平移点数组。
pub fn translate_points(
  points : Array[Point2D],
  dx : Double,
  dy : Double,
) -> Array[Point2D] {
  @transform.translate_points(points, dx, dy)
}
