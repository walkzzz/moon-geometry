///|
pub fn wave_explicit_step(
  u_prev : Array[Double],
  u_curr : Array[Double],
  c : Double,
  dt : Double,
  dx : Double,
) -> Array[Double] {
  let n = u_curr.length()
  let r = c * dt / dx
  let r2 = r * r
  let result = Array::make(n, 0.0)
  for i in 0..<n {
    let left = if i > 0 { u_curr[i - 1] } else { u_curr[i] }
    let right = if i < n - 1 { u_curr[i + 1] } else { u_curr[i] }
    result[i] = 2.0 * u_curr[i] -
      u_prev[i] +
      r2 * (left - 2.0 * u_curr[i] + right)
  }
  result
}
