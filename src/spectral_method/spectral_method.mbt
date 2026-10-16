///|
/// # Spectral Method
/// # 谱方法
///
/// Spectral methods for PDEs using Chebyshev and Fourier bases.
/// 使用 Chebyshev 和 Fourier 基的 PDE 谱方法。

///|
pub fn chebyshev_node(n : Int, i : Int) -> Double {
  @math.cos((2.0 * i.to_double() + 1.0) * 3.141592653589793 / (2.0 * n.to_double()))
}

///|
pub fn chebyshev_weight(n : Int, _ : Int) -> Double {
  3.141592653589793 / n.to_double()
}

///|
pub fn fourier_coeff(f_values : Array[Double], k : Int) -> Double {
  let n = f_values.length()
  if n == 0 { return 0.0 }
  let mut sum = 0.0
  for i in 0..<n {
    let theta = 2.0 * 3.141592653589793 * k.to_double() * i.to_double() / n.to_double()
    sum += f_values[i] * @math.cos(theta)
  }
  2.0 * sum / n.to_double()
}

///|
pub fn spectral_derivative(coeffs : Array[Double], x : Double) -> Double {
  let mut sum = 0.0
  for k in 1..<coeffs.length() {
    sum += k.to_double() * coeffs[k] * @math.sin(k.to_double() * x)
  }
  -sum
}

///|
pub fn spectral_interp(coeffs : Array[Double], x : Double) -> Double {
  let mut sum = 0.0
  for k in 0..<coeffs.length() {
    sum += coeffs[k] * @math.cos(k.to_double() * x)
  }
  sum
}
