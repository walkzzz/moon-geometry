///|
/// # Maxwell Solver | 麦克斯韦方程求解器
/// Maxwell's equations FDTD solver. / 麦克斯韦方程 FDTD 求解器。
///|
pub fn fdtd_update_e(e : Array[Double], h : Array[Double], dt : Double, dx : Double, eps : Double) -> Array[Double] {
  let n = e.length()
  let coef = dt / (eps * dx)
  let result = []
  for i in 0..<n { result.push(e[i]) }
  for i in 0..<(n - 1) {
    result[i] += coef * (h[i + 1] - h[i])
  }
  result
}
///|
pub fn fdtd_update_h(e : Array[Double], h : Array[Double], dt : Double, dx : Double, mu : Double) -> Array[Double] {
  let n = h.length()
  let coef = dt / (mu * dx)
  let result = []
  for i in 0..<n { result.push(h[i]) }
  for i in 1..<n {
    result[i] += coef * (e[i] - e[i - 1])
  }
  result
}
///|
pub fn courant_condition(dx : Double, dy : Double, dz : Double, c : Double) -> Double {
  let inv = 1.0 / (dx * dx) + 1.0 / (dy * dy) + 1.0 / (dz * dz)
  if inv.abs() < 0.000000000001 { 0.0 } else { 1.0 / (c * inv.sqrt()) }
}
