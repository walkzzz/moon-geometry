///|
pub fn flow_perimeters(pts : Array[Point2D], steps : Int, dt : Double) -> Array[Double] {
  @polygon_evolve.flow_perimeters(pts, steps, dt)
}

///|
pub fn flow_areas(pts : Array[Point2D], steps : Int, dt : Double) -> Array[Double] {
  @polygon_evolve.flow_areas(pts, steps, dt)
}

// ---------------------------------------------------------------------------
// polygon_morph: Polygon morphing / 多边形变形
// ---------------------------------------------------------------------------

///|
pub fn morph(pts1 : Array[Point2D], pts2 : Array[Point2D], t : Double) -> Array[Point2D] {
  @polygon_morph.morph(pts1, pts2, t)
}

///|
pub fn morph_sequence(pts1 : Array[Point2D], pts2 : Array[Point2D], n_steps : Int) -> Array[Array[Point2D]] {
  @polygon_morph.morph_sequence(pts1, pts2, n_steps)
}

///|
pub fn best_alignment(pts1 : Array[Point2D], pts2 : Array[Point2D]) -> Int {
  @polygon_morph.best_alignment(pts1, pts2)
}

///|
pub fn morph_aligned(pts1 : Array[Point2D], pts2 : Array[Point2D], t : Double) -> Array[Point2D] {
  @polygon_morph.morph_aligned(pts1, pts2, t)
}

// ---------------------------------------------------------------------------
// polygon_decomp_opt: Optimal convex decomposition / 最优凸分解
// ---------------------------------------------------------------------------

///|
pub fn optimal_convex_decomp(pts : Array[Point2D]) -> Array[Array[Point2D]] {
  @polygon_decomp_opt.optimal_convex_decomp(pts)
}