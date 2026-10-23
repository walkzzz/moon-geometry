///|
pub fn fast_marching_step(
  narrow_band : Array[(Int32, Double)],
  f : Double,
  h : Double,
) -> Array[(Int32, Double)] {
  let result : Array[(Int32, Double)] = []
  for i in 0..<narrow_band.length() {
    let (idx, u) = narrow_band[i]
    result.push((idx, u + h / f))
  }
  result
}

///|
pub fn is_far(value : Double) -> Bool {
  value > 99999999.0
}
