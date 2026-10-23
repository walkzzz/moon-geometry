///|
/// Compute Fourier descriptors of a closed boundary.
/// 计算闭合边界的傅里叶描述子。
///
/// Returns complex coefficients (real, imag) padded to power of two.
/// 返回复数系数 (实, 虚)，填充至 2 的幂。
pub fn fourier_descriptors(
  points : Array[@core.Point2D],
) -> Array[(Double, Double)] {
  let n = points.length()
  let result : Array[(Double, Double)] = []
  if n == 0 {
    return result
  }
  let n2 = next_pow2(n)
  let re : Array[Double] = Array::make(n2, 0.0)
  let im : Array[Double] = Array::make(n2, 0.0)
  for i in 0..<n {
    re[i] = points[i].x()
    im[i] = points[i].y()
  }
  fft(re, im, false)
  for i in 0..<n2 {
    result.push((re[i], im[i]))
  }
  result
}
