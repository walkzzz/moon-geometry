///|
pub fn bem_error(exact : Array[Double], approx : Array[Double]) -> Double {
  let mut sum = 0.0
  for i in 0..<exact.length() {
    let diff = exact[i] - approx[i]
    sum += diff * diff
  }
  sum.sqrt()
}
