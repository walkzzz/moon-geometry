///|
pub fn scene_to_json(pts : Array[Point2D], segs : Array[Segment], circs : Array[Circle]) -> String {
  @json_out.scene_to_json(pts, segs, circs)
}
// ---------------------------------------------------------------------------
// convex_hull_approx: Approximate convex hull / 近似凸包
// ---------------------------------------------------------------------------

///|
pub fn approx_convex_hull(points : Array[Point2D], grid_size : Int) -> Array[Point2D] {
  @convex_hull_approx.approx_convex_hull(points, grid_size)
}

///|
pub fn approx_hull_area(points : Array[Point2D]) -> Double {
  @convex_hull_approx.approx_hull_area(points)
}

///|
pub fn approx_hull_perimeter(points : Array[Point2D]) -> Double {
  @convex_hull_approx.approx_hull_perimeter(points)
}

///|
pub fn approx_error_bound(points : Array[Point2D], grid_size : Int) -> Double {
  @convex_hull_approx.approx_error_bound(points, grid_size)
}

// ---------------------------------------------------------------------------
// convex_hull_dynamic: Dynamic convex hull / 动态凸包
// ---------------------------------------------------------------------------

///|
pub type DynamicHull = @convex_hull_dynamic.DynamicHull

///|
pub fn dynamic_hull_new() -> DynamicHull {
  @convex_hull_dynamic.DynamicHull::new()
}