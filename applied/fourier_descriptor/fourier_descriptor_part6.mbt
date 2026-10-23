///|
/// Truncate Fourier descriptors to keep only first k coefficients (low-pass).
/// 截断傅里叶描述子，仅保留前 k 个系数（低通）。
pub fn fourier_truncate(
  coeffs : Array[(Double, Double)],
  k : Int32,
) -> Array[(Double, Double)] {
  let result : Array[(Double, Double)] = []
  let nc = coeffs.length()
  let keep = if k < nc { k } else { nc }
  for i in 0..<keep {
    result.push(coeffs[i])
  }
  for _ in keep..<nc {
    result.push((0.0, 0.0))
  }
  result
}
