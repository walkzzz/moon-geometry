///|
/// Constrained Delaunay triangulation. / 约束 Delaunay 三角剖分。
pub type ConstrainedDelaunay = @constrained_delaunay.ConstrainedDelaunay

pub fn constrained_delaunay_new() -> ConstrainedDelaunay {
  @constrained_delaunay.ConstrainedDelaunay::new()
}

pub fn constrained_delaunay_triangle_count(cd : ConstrainedDelaunay) -> Int {
  @constrained_delaunay.ConstrainedDelaunay::triangle_count(cd)
}

pub fn constrained_delaunay_constraint_count(cd : ConstrainedDelaunay) -> Int {
  @constrained_delaunay.ConstrainedDelaunay::constraint_count(cd)
}

pub fn is_constrained_edge(cd : ConstrainedDelaunay, a : Int, b : Int) -> Bool {
  @constrained_delaunay.is_constrained_edge(cd, a, b)
}

pub fn add_constraint(cd : ConstrainedDelaunay, a : Int, b : Int) -> Unit {
  @constrained_delaunay.add_constraint(cd, a, b)
}

pub fn constrained_delaunay(
  points : Array[Point2D],
  constraints : Array[(Int, Int)],
) -> ConstrainedDelaunay {
  @constrained_delaunay.constrained_delaunay(points, constraints)
}

pub fn constrained_triangle_count(cd : ConstrainedDelaunay) -> Int {
  @constrained_delaunay.constrained_triangle_count(cd)
}

// ---------------------------------------------------------------------------
// power_diagram: Power diagram / 幂图
// ---------------------------------------------------------------------------


///|
/// Weighted point for power diagram. / 幂图加权站点。
pub type WeightedPoint = @power_diagram.WeightedPoint


///|
/// Power cell. / 幂单元。
pub type PowerCell = @power_diagram.PowerCell


///|
/// Power diagram. / 幂图。
pub type PowerDiagram = @power_diagram.PowerDiagram

pub fn weighted_point_new(point : Point2D, weight : Double) -> WeightedPoint {
  @power_diagram.WeightedPoint::new(point, weight)
}

pub fn power_diagram_new() -> PowerDiagram {
  @power_diagram.PowerDiagram::new()
}

pub fn power_diagram_cell_count(pd : PowerDiagram) -> Int {
  @power_diagram.PowerDiagram::cell_count(pd)
}

pub fn power_distance(x : Point2D, site : WeightedPoint) -> Double {
  @power_diagram.power_distance(x, site)
}

pub fn power_diagram(
  sites : Array[WeightedPoint],
  bounds : (Point2D, Point2D),
) -> PowerDiagram {
  @power_diagram.power_diagram(sites, bounds)
}

pub fn power_cell(pd : PowerDiagram, site_idx : Int) -> PowerCell {
  @power_diagram.power_cell(pd, site_idx)
}

pub fn power_cell_area(pd : PowerDiagram, site_idx : Int) -> Double {
  @power_diagram.power_cell_area(pd, site_idx)
}

pub fn regular_triangulation(sites : Array[WeightedPoint]) -> Array[(Int, Int, Int)] {
  @power_diagram.regular_triangulation(sites)
}

// ---------------------------------------------------------------------------
// centroidal_voronoi: Centroidal Voronoi tessellation / 质心 Voronoi 镶嵌
// ---------------------------------------------------------------------------


///|
/// CVT result. / CVT 结果。
pub type CVTResult = @centroidal_voronoi.CVTResult

pub fn cvt_result_new() -> CVTResult {
  @centroidal_voronoi.CVTResult::new()
}

pub fn compute_centroid(poly : Array[Point2D]) -> Point2D {
  @centroidal_voronoi.compute_centroid(poly)
}

pub fn lloyd_energy(sites : Array[Point2D], bounds : (Point2D, Point2D)) -> Double {
  @centroidal_voronoi.lloyd_energy(sites, bounds)
}

pub fn lloyd_iteration(
  sites : Array[Point2D],
  bounds : (Point2D, Point2D),
  max_iter : Int,
) -> Array[Point2D] {
  @centroidal_voronoi.lloyd_iteration(sites, bounds, max_iter)
}

pub fn centroidal_voronoi(
  sites : Array[Point2D],
  bounds : (Point2D, Point2D),
  max_iter : Int,
) -> CVTResult {
  @centroidal_voronoi.centroidal_voronoi(sites, bounds, max_iter)
}

// ---------------------------------------------------------------------------
// alpha_complex: Alpha complex / Alpha 复形
// ---------------------------------------------------------------------------


///|
/// Alpha simplex. / Alpha 单纯形。
pub type AlphaSimplex = @alpha_complex.AlphaSimplex
