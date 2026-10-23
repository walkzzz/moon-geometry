///|
pub fn fast_marching_step(narrow_band : Array[(Int, Double)], f : Double, h : Double) -> Array[(Int, Double)] {
  let result : Array[(Int, Double)] = []
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
