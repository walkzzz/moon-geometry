///|
pub fn visibility_vertices(obstacles : Array[Array[Point2D]], start : Point2D, goal : Point2D) -> Array[Point2D] {
  @visibility_graph.visibility_vertices(obstacles, start, goal)
}

///|
pub fn visibility_edge_count(obstacles : Array[Array[Point2D]], start : Point2D, goal : Point2D) -> Int {
  @visibility_graph.visibility_edge_count(obstacles, start, goal)
}

// ---------------------------------------------------------------------------
// motion_plan: Motion planning / 运动规划
// ---------------------------------------------------------------------------

///|
pub fn plan_path(obstacles : Array[Array[Point2D]], start : Point2D, goal : Point2D) -> Array[Point2D] {
  @motion_plan.plan_path(obstacles, start, goal)
}

///|
pub fn path_length(path : Array[Point2D]) -> Double {
  @motion_plan.path_length(path)
}

///|
pub fn is_path_valid(path : Array[Point2D], obstacles : Array[Array[Point2D]]) -> Bool {
  @motion_plan.is_path_valid(path, obstacles)
}

// ---------------------------------------------------------------------------
// voronoi_adv: Advanced Voronoi / 高级 Voronoi
// ---------------------------------------------------------------------------

///|
pub fn voronoi_cell(sites : Array[Point2D], site_idx : Int, bounds : (Point2D, Point2D)) -> Array[Point2D] {
  @voronoi_adv.voronoi_cell(sites, site_idx, bounds)
}

///|
pub fn farthest_voronoi_cell(sites : Array[Point2D], site_idx : Int, bounds : (Point2D, Point2D)) -> Array[Point2D] {
  @voronoi_adv.farthest_voronoi_cell(sites, site_idx, bounds)
}