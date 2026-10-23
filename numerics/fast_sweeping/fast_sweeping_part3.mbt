///|
pub fn sweeping_converged(
  u_old : Array[Double],
  u_new : Array[Double],
  tol : Double,
) -> Bool {
  let mut max_diff = 0.0
  for i in 0..<u_old.length() {
    let diff = (u_new[i] - u_old[i]).abs()
    if diff > max_diff {
      max_diff = diff
    }
  }
  max_diff < tol
}
