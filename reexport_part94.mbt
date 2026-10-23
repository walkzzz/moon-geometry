///|
pub fn simplify_topology_preserve(pts : Array[Point2D], eps : Double) -> Array[Point2D] {
  @polygon_simplify.simplify_topology_preserve(pts, eps)
}

///|
pub fn simplify_visvalingam(pts : Array[Point2D], target_count : Int) -> Array[Point2D] {
  @polygon_simplify.simplify_visvalingam(pts, target_count)
}

///|
pub fn douglas_peucker(pts : Array[Point2D], eps : Double) -> Array[Point2D] {
  @polygon_simplify.douglas_peucker(pts, eps)
}

// ---------------------------------------------------------------------------
// polygon_round: Polygon corner rounding / 多边形圆角化
// ---------------------------------------------------------------------------

///|
pub fn round_polygon(pts : Array[Point2D], radius : Double, segments : Int) -> Array[Point2D] {
  @polygon_round.round_polygon(pts, radius, segments)
}

///|
pub fn round_corner(p1 : Point2D, p2 : Point2D, p3 : Point2D, radius : Double, segments : Int) -> Array[Point2D] {
  @polygon_round.round_corner(p1, p2, p3, radius, segments)
}

// ---------------------------------------------------------------------------
// polygon_evolve: Curve shortening flow / 曲率流
// ---------------------------------------------------------------------------

///|
pub fn curve_shortening_flow(pts : Array[Point2D], steps : Int, dt : Double) -> Array[Array[Point2D]] {
  @polygon_evolve.curve_shortening_flow(pts, steps, dt)
}

///|
pub fn evolve_step(pts : Array[Point2D], dt : Double) -> Array[Point2D] {
  @polygon_evolve.evolve_step(pts, dt)
}