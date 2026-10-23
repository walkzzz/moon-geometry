///|
pub fn lax_friedrichs(u : Array[Double], c : Double, dt : Double, dx : Double) -> Array[Double] {
  let n = u.length()
  let coef = c * dt / (2.0 * dx)
  let result = Array::make(n, 0.0)
  for i in 0..<n {
    let left = if i > 0 { u[i - 1] } else { u[i] }
    let right = if i < n - 1 { u[i + 1] } else { u[i] }
    result[i] = 0.5 * (left + right) - coef * (right - left)
  }
  result
}