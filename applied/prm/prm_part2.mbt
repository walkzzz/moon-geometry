///|
/// Construct PRM result. / 构造 PRM 结果。
pub fn PRMResult::new(
  path : Array[@core.Point2D],
  success : Bool,
  distance : Double,
) -> PRMResult {
  { path, success, distance, }
}

///|
fn rng_next(state : UInt32) -> UInt32 {
  state * 1103515245U + 12345U
}

///|
fn rng_double(state : UInt32) -> (Double, UInt32) {
  let s = rng_next(state)
  ((s % 1000000U).to_double() / 1000000.0, s)
}

///|
fn point_dist(a : @core.Point2D, b : @core.Point2D) -> Double {
  a.dist(b)
}

///|
fn segment_hits_obstacle(
  a : @core.Point2D,
  b : @core.Point2D,
  obstacles : Array[Array[@core.Point2D]],
) -> Bool {
  for k in 0..<obstacles.length() {
    let obs = obstacles[k]
    let m = obs.length()
    for e in 0..<m {
      if seg_cross(a, b, obs[e], obs[(e + 1) % m]) {
        return true
      }
    }
  }
  false
}

///|
fn seg_cross(
  a1 : @core.Point2D,
  a2 : @core.Point2D,
  b1 : @core.Point2D,
  b2 : @core.Point2D,
) -> Bool {
  let d1 = @core.turn(b1, b2, a1)
  let d2 = @core.turn(b1, b2, a2)
  let d3 = @core.turn(a1, a2, b1)
  let d4 = @core.turn(a1, a2, b2)
  ((d1 > 0.0 && d2 < 0.0) || (d1 < 0.0 && d2 > 0.0)) &&
  ((d3 > 0.0 && d4 < 0.0) || (d3 < 0.0 && d4 > 0.0))
}
