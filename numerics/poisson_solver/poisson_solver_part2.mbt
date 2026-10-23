///|
pub fn poisson_gauss_seidel(
  u : Array[Double],
  f : Array[Double],
  h : Double,
) -> Array[Double] {
  let n = u.length()
  let h2 = h * h
  let result = []
  for i in 0..<n {
    result.push(u[i])
  }
  for i in 0..<n {
    let left = if i > 0 { result[i - 1] } else { 0.0 }
    let right = if i < n - 1 { u[i + 1] } else { 0.0 }
    result[i] = 0.5 * (left + right - h2 * f[i])
  }
  result
}
