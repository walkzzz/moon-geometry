///|
pub fn heat_explicit_step(u : Array[Double], alpha : Double, dt : Double, dx : Double) -> Array[Double] {
  let n = u.length()
  let r = alpha * dt / (dx * dx)
  let result = Array::make(n, 0.0)
  for i in 0..<n {
    let left = if i > 0 { u[i - 1] } else { u[i] }
    let right = if i < n - 1 { u[i + 1] } else { u[i] }
    result[i] = u[i] + r * (left - 2.0 * u[i] + right)
  }
  result
}