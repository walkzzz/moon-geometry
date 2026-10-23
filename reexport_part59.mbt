///|
pub fn match_count(a : Array[Point2D], b : Array[Point2D], t : Double) -> Int {
  @pmatch.match_count(a, b, t)
}

///|
pub fn match_ratio(a : Array[Point2D], b : Array[Point2D], t : Double) -> Double {
  @pmatch.match_ratio(a, b, t)
}

///|
pub fn unmatched_a(a : Array[Point2D], b : Array[Point2D], t : Double) -> Int {
  @pmatch.unmatched_a(a, b, t)
}

///|
pub fn unmatched_b(a : Array[Point2D], b : Array[Point2D], t : Double) -> Int {
  @pmatch.unmatched_b(a, b, t)
}

// ---------------------------------------------------------------------------
// dtw: dynamic time warping / DTW
// ---------------------------------------------------------------------------

///|
pub fn dtw_distance(c1 : Array[Point2D], c2 : Array[Point2D]) -> Double {
  @dtw.dtw_distance(c1, c2)
}

///|
pub fn dtw_windowed(c1 : Array[Point2D], c2 : Array[Point2D], w : Int) -> Double {
  @dtw.dtw_windowed(c1, c2, w)
}

///|
pub fn dtw_normalized(c1 : Array[Point2D], c2 : Array[Point2D]) -> Double {
  @dtw.dtw_normalized(c1, c2)
}

// ---------------------------------------------------------------------------
// metric_tree: metric tree / 度量树
// ---------------------------------------------------------------------------