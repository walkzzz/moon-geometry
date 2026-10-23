///|
pub fn decomp_count(pts : Array[Point2D]) -> Int {
  @polygon_decomp_opt.decomp_count(pts)
}

///|
pub fn is_convex_check(pts : Array[Point2D]) -> Bool {
  @polygon_decomp_opt.is_convex_polygon(pts)
}

// ---------------------------------------------------------------------------
// polygon_triangulate_fast: Fast triangulation / 快速三角剖分
// ---------------------------------------------------------------------------

///|
pub fn fast_triangulate(pts : Array[Point2D]) -> Array[(Int, Int, Int)] {
  @polygon_triangulate_fast.fast_triangulate(pts)
}

///|
pub fn fast_triangulate_points(pts : Array[Point2D]) -> Array[(Point2D, Point2D, Point2D)] {
  @polygon_triangulate_fast.fast_triangulate_points(pts)
}

///|
pub fn triangle_count(pts : Array[Point2D]) -> Int {
  @polygon_triangulate_fast.triangle_count(pts)
}

///|
pub fn total_triangle_area(pts : Array[Point2D]) -> Double {
  @polygon_triangulate_fast.total_triangle_area(pts)
}
// ---------------------------------------------------------------------------
// rtree: R-tree / R树
// ---------------------------------------------------------------------------

///|
pub type RTree = @rtree.RTree