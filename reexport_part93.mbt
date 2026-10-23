///|
pub fn convex_polygon_intersection(poly1 : Polygon, poly2 : Polygon) -> Array[Point2D] {
  @convex_intersection.convex_polygon_intersection(poly1, poly2)
}

///|
pub fn convex_intersects(poly1 : Polygon, poly2 : Polygon) -> Bool {
  @convex_intersection.convex_polygons_intersect(poly1, poly2)
}

///|
pub fn intersection_area(poly1 : Polygon, poly2 : Polygon) -> Double {
  @convex_intersection.intersection_area(poly1, poly2)
}
// ---------------------------------------------------------------------------
// polygon_skeleton: Straight skeleton / 直骨架
// ---------------------------------------------------------------------------

///|
pub fn straight_skeleton(poly : Polygon) -> Array[Segment] {
  @polygon_skeleton.straight_skeleton(poly)
}

///|
pub fn skeleton_faces(poly : Polygon) -> Array[Array[Point2D]] {
  @polygon_skeleton.skeleton_faces(poly)
}

// ---------------------------------------------------------------------------
// polygon_medial: Medial axis / 中轴线
// ---------------------------------------------------------------------------

///|
pub fn medial_axis(poly : Polygon, resolution : Int) -> Array[Segment] {
  @polygon_medial.medial_axis(poly, resolution)
}

///|
pub fn medial_axis_points(poly : Polygon, n_samples : Int) -> Array[Point2D] {
  @polygon_medial.medial_axis_points(poly, n_samples)
}

// ---------------------------------------------------------------------------
// polygon_simplify: Polygon simplification / 多边形简化
// ---------------------------------------------------------------------------