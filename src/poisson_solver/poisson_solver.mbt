///|
/// # Poisson Solver | 泊松方程求解器
/// Poisson equation solver. / 泊松方程求解器。
///|
pub fn poisson_jacobi(u : Array[Double], f : Array[Double], h : Double) -> Array[Double] {
  let n = u.length()
  let h2 = h * h
  let result = Array::make(n, 0.0)
  for i in 0..<n {
    let left = if i > 0 { u[i - 1] } else { 0.0 }
    let right = if i < n - 1 { u[i + 1] } else { 0.0 }
    result[i] = 0.5 * (left + right - h2 * f[i])
  }
  result
}
///|
pub fn poisson_gauss_seidel(u : Array[Double], f : Array[Double], h : Double) -> Array[Double] {
  let n = u.length()
  let h2 = h * h
  let result = []
  for i in 0..<n { result.push(u[i]) }
  for i in 0..<n {
    let left = if i > 0 { result[i - 1] } else { 0.0 }
    let right = if i < n - 1 { u[i + 1] } else { 0.0 }
    result[i] = 0.5 * (left + right - h2 * f[i])
  }
  result
}
///|
pub fn poisson_residual(u : Array[Double], f : Array[Double], h : Double) -> Double {
  let n = u.length()
  let h2 = h * h
  let mut max_r = 0.0
  for i in 0..<n {
    let left = if i > 0 { u[i - 1] } else { 0.0 }
    let right = if i < n - 1 { u[i + 1] } else { 0.0 }
    let r = (left - 2.0 * u[i] + right) / h2 - f[i]
    if r.abs() > max_r { max_r = r.abs() }
  }
  max_r
}
