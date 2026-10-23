///|
/// Rotation/translation/scale invariant Fourier descriptors.
/// 旋转/平移/缩放不变的傅里叶描述子。
///
/// Normalize by |FD[1]|, take magnitudes, skip DC component (index 0).
/// 以 |FD[1]| 归一化，取模长，跳过直流分量（索引 0）。
pub fn fourier_invariant(points : Array[@core.Point2D]) -> Array[Double] {
  let coeffs = fourier_descriptors(points)
  let result : Array[Double] = []
  if coeffs.length() < 2 {
    return result
  }
  let (r1, i1) = coeffs[1]
  let mag1 = (r1 * r1 + i1 * i1).sqrt()
  if mag1 < 0.000000000001 {
    for _ in 1..<coeffs.length() {
      result.push(0.0)
    }
    return result
  }
  for i in 1..<coeffs.length() {
    let (re, im) = coeffs[i]
    let mag = (re * re + im * im).sqrt()
    result.push(mag / mag1)
  }
  result
}
