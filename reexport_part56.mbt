///|
/// Radius of curvature. / 曲率半径。
pub fn curvature_radius(p1 : Point2D, p2 : Point2D, p3 : Point2D) -> Double {
  @curvature.curvature_radius(p1, p2, p3)
}


///|
/// Total curvature. / 总曲率。
pub fn curvature_total(pts : Array[Point2D]) -> Double {
  @curvature.curvature_total(pts)
}
// ---------------------------------------------------------------------------
// hausdorff: Hausdorff distance / Hausdorff 距离
// ---------------------------------------------------------------------------

///|
pub fn hausdorff_directed(a : Array[Point2D], b : Array[Point2D]) -> Double {
  @hausdorff.hausdorff_directed(a, b)
}

///|
pub fn hausdorff_distance(a : Array[Point2D], b : Array[Point2D]) -> Double {
  @hausdorff.hausdorff_distance(a, b)
}

///|
pub fn hausdorff_within(a : Array[Point2D], b : Array[Point2D], eps : Double) -> Bool {
  @hausdorff.hausdorff_within(a, b, eps)
}

///|
pub fn partial_hausdorff(a : Array[Point2D], b : Array[Point2D], k : Int) -> Double {
  @hausdorff.partial_hausdorff(a, b, k)
}

// ---------------------------------------------------------------------------
// frechet: Fréchet distance / Fréchet 距离
// ---------------------------------------------------------------------------

///|
pub fn frechet_distance(c1 : Array[Point2D], c2 : Array[Point2D]) -> Double {
  @frechet.frechet_distance(c1, c2)
}