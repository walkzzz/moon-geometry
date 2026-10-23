///|
pub fn voronoi_cell_area(sites : Array[Point2D], site_idx : Int, bounds : (Point2D, Point2D)) -> Double {
  @voronoi_adv.voronoi_cell_area(sites, site_idx, bounds)
}

///|
pub fn voronoi_cell_count(sites : Array[Point2D]) -> Int {
  @voronoi_adv.voronoi_cell_count(sites)
}

// ---------------------------------------------------------------------------
// delaunay_refine: Delaunay refinement / Delaunay 细化
// ---------------------------------------------------------------------------

///|
pub fn delaunay_refine(pts : Array[Point2D], min_angle : Double, max_iter : Int) -> Array[Point2D] {
  @delaunay_refine.delaunay_refine(pts, min_angle, max_iter)
}

///|
pub fn circumcenter(a : Point2D, b : Point2D, c : Point2D) -> Point2D {
  @delaunay_refine.circumcenter(a, b, c)
}

///|
pub fn min_triangle_angle(a : Point2D, b : Point2D, c : Point2D) -> Double {
  @delaunay_refine.min_triangle_angle(a, b, c)
}

///|
pub fn delaunay_triangle_count(pts : Array[Point2D]) -> Int {
  @delaunay_refine.triangle_count(pts)
}

// ---------------------------------------------------------------------------
// graph_color: Graph coloring / 图着色
// ---------------------------------------------------------------------------

///|
pub fn greedy_color(n : Int, adj : Array[Array[Int]]) -> Array[Int] {
  @graph_color.greedy_color(n, adj)
}