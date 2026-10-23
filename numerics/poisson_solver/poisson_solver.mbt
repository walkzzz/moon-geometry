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