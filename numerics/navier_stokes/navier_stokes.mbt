///|
/// # Navier-Stokes | 纳维-斯托克斯
/// Navier-Stokes solver. / 纳维-斯托克斯求解器。
///|
pub fn ns_advection(u : Array[Double], v : Array[Double], dx : Double, dy : Double) -> Array[Double] {
  let n = u.length()
  let result = Array::make(n, 0.0)
  for i in 1..<(n - 1) {
    let du_dx = (u[i + 1] - u[i - 1]) / (2.0 * dx)
    let dv_dy = (v[i + 1] - v[i - 1]) / (2.0 * dy)
    result[i] = -u[i] * du_dx - v[i] * dv_dy
  }
  result
}
///|
pub fn ns_diffusion(u : Array[Double], nu : Double, dx : Double) -> Array[Double] {
  let n = u.length()
  let result = Array::make(n, 0.0)
  for i in 1..<(n - 1) {
    result[i] = nu * (u[i + 1] - 2.0 * u[i] + u[i - 1]) / (dx * dx)
  }
  result
}
///|
pub fn ns_pressure_gradient(p : Array[Double], dx : Double) -> Array[Double] {
  let n = p.length()
  let result = Array::make(n, 0.0)
  for i in 1..<(n - 1) {
    result[i] = (p[i + 1] - p[i - 1]) / (2.0 * dx)
  }
  result
}
///|
pub fn ns_reynolds_number(rho : Double, v : Double, length : Double, mu : Double) -> Double {
  if mu.abs() < 0.000000000001 { 0.0 } else { rho * v * length / mu }
}
