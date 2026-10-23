///|
pub fn convex_radius_lower_bound(poly : Polygon) -> Double {
  @convex_diameter.convex_radius_lower_bound(poly)
}

///|
pub fn antipodal_pairs(poly : Polygon) -> Array[(Int, Int)] {
  @convex_diameter.antipodal_pairs(poly)
}

// ---------------------------------------------------------------------------
// convex_center: Convex polygon centers / 凸多边形中心
// ---------------------------------------------------------------------------

///|
pub fn convex_centroid(poly : Polygon) -> Point2D {
  @convex_center.convex_centroid(poly)
}

///|
pub fn chebyshev_center(poly : Polygon) -> Point2D {
  @convex_center.chebyshev_center(poly)
}

///|
pub fn bbox_center(poly : Polygon) -> Point2D {
  @convex_center.bbox_center(poly)
}

///|
pub fn vertex_center(poly : Polygon) -> Point2D {
  @convex_center.vertex_center(poly)
}

///|
pub fn inradius(poly : Polygon) -> Double {
  @convex_center.inradius(poly)
}

// ---------------------------------------------------------------------------
// convex_intersection: Convex polygon intersection / 凸多边形交集
// ---------------------------------------------------------------------------