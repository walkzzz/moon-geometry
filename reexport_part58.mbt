///|
pub fn emd_uniform(a : Array[Point2D], b : Array[Point2D]) -> Double {
  @emd.emd_uniform(a, b)
}

///|
pub fn emd_weighted(pos : Array[Double], wa : Array[Double], wb : Array[Double]) -> Double {
  @emd.emd_weighted(pos, wa, wb)
}

// ---------------------------------------------------------------------------
// bottleneck: bottleneck matching / 瓶颈匹配
// ---------------------------------------------------------------------------

///|
pub fn bottleneck_distance(a : Array[Point2D], b : Array[Point2D]) -> Double {
  @bottleneck.bottleneck_distance(a, b)
}

///|
pub fn bottleneck_within(a : Array[Point2D], b : Array[Point2D], t : Double) -> Bool {
  @bottleneck.bottleneck_within(a, b, t)
}

///|
pub fn bottleneck_match(a : Array[Point2D], b : Array[Point2D]) -> Array[(Int, Int, Double)] {
  @bottleneck.bottleneck_match(a, b)
}

///|
pub fn bottleneck_max(a : Array[Point2D], b : Array[Point2D]) -> Double {
  @bottleneck.bottleneck_max(a, b)
}

// ---------------------------------------------------------------------------
// pmatch: point matching / 点匹配
// ---------------------------------------------------------------------------

///|
pub fn point_match(a : Array[Point2D], b : Array[Point2D], t : Double) -> Array[(Int, Int)] {
  @pmatch.point_match(a, b, t)
}