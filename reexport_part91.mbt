///|
pub fn concave_hull(points : Array[Point2D], k : Int) -> Array[Point2D] {
  @concave_hull.concave_hull(points, k)
}

///|
pub fn concave_hull_default(points : Array[Point2D]) -> Array[Point2D] {
  @concave_hull.concave_hull_default(points)
}

// ---------------------------------------------------------------------------
// convex_width: Convex polygon width / 凸多边形宽度
// ---------------------------------------------------------------------------

///|
pub fn convex_width(poly : Polygon) -> Double {
  @convex_width.convex_width(poly)
}

///|
pub fn convex_max_width(poly : Polygon) -> Double {
  @convex_width.convex_max_width(poly)
}

///|
pub fn convex_aspect_ratio(poly : Polygon) -> Double {
  @convex_width.convex_aspect_ratio(poly)
}

// ---------------------------------------------------------------------------
// convex_diameter: Convex polygon diameter / 凸多边形直径
// ---------------------------------------------------------------------------

///|
pub fn convex_diameter(poly : Polygon) -> Double {
  @convex_diameter.convex_diameter(poly)
}

///|
pub fn convex_diameter_pair(poly : Polygon) -> (Point2D, Point2D) {
  @convex_diameter.convex_diameter_pair(poly)
}