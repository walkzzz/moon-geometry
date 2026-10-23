///|
pub fn frechet_within(c1 : Array[Point2D], c2 : Array[Point2D], eps : Double) -> Bool {
  @frechet.frechet_within(c1, c2, eps)
}

///|
pub fn frechet_point_distance(p1 : Point2D, p2 : Point2D) -> Double {
  @frechet.frechet_point_distance(p1, p2)
}

// ---------------------------------------------------------------------------
// chamfer: Chamfer distance / Chamfer 距离
// ---------------------------------------------------------------------------

///|
pub fn chamfer_directed(a : Array[Point2D], b : Array[Point2D]) -> Double {
  @chamfer.chamfer_directed(a, b)
}

///|
pub fn chamfer_distance(a : Array[Point2D], b : Array[Point2D]) -> Double {
  @chamfer.chamfer_distance(a, b)
}

///|
pub fn chamfer_squared_directed(a : Array[Point2D], b : Array[Point2D]) -> Double {
  @chamfer.chamfer_squared_directed(a, b)
}

///|
pub fn chamfer_rms(a : Array[Point2D], b : Array[Point2D]) -> Double {
  @chamfer.chamfer_rms(a, b)
}

// ---------------------------------------------------------------------------
// emd: Earth Mover's Distance / EMD 距离
// ---------------------------------------------------------------------------

///|
pub fn emd_1d(a : Array[Double], b : Array[Double]) -> Double {
  @emd.emd_1d(a, b)
}