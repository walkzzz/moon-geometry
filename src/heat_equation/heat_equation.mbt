///|
/// # Heat Equation | 热传导方程
/// Heat equation solver. / 热传导方程求解器。
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
///|
pub fn heat_steady_state_1d(boundary_left : Double, boundary_right : Double, n : Int) -> Array[Double] {
  let result = Array::make(n, 0.0)
  for i in 0..<n {
    result[i] = boundary_left + (boundary_right - boundary_left) * i.to_double() / (n - 1).to_double()
  }
  result
}
///|
pub fn heat_analytical_1d(x : Double, t : Double, alpha : Double, length : Double) -> Double {
  @math.exp(-alpha * @math.PI * @math.PI * t / (length * length)) * @math.sin(@math.PI * x / length)
}
