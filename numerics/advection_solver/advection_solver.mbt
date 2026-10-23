///|
/// # Advection Solver | 平流方程求解器
/// Advection equation solver. / 平流方程求解器。

///|
pub fn upwind_advection(
  u : Array[Double],
  c : Double,
  dt : Double,
  dx : Double,
) -> Array[Double] {
  let n = u.length()
  let coef = c * dt / dx
  let result = Array::make(n, 0.0)
  for i in 0..<n {
    let upwind = if c > 0.0 {
      if i > 0 {
        u[i - 1]
      } else {
        u[i]
      }
    } else if i < n - 1 {
      u[i + 1]
    } else {
      u[i]
    }
    result[i] = u[i] - coef * (u[i] - upwind)
  }
  result
}

///|
pub fn lax_friedrichs(
  u : Array[Double],
  c : Double,
  dt : Double,
  dx : Double,
) -> Array[Double] {
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

///|
pub fn lax_wendroff(
  u : Array[Double],
  c : Double,
  dt : Double,
  dx : Double,
) -> Array[Double] {
  let n = u.length()
  let r = c * dt / dx
  let result = Array::make(n, 0.0)
  for i in 0..<n {
    let left = if i > 0 { u[i - 1] } else { u[i] }
    let right = if i < n - 1 { u[i + 1] } else { u[i] }
    result[i] = u[i] -
      0.5 * r * (right - left) +
      0.5 * r * r * (right - 2.0 * u[i] + left)
  }
  result
}
