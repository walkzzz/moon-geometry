///|
/// Reconstruct boundary from Fourier descriptors.
/// 从傅里叶描述子重建边界。
pub fn fourier_reconstruct(
  coeffs : Array[(Double, Double)],
  n : Int32,
) -> Array[@core.Point2D] {
  let result : Array[@core.Point2D] = []
  let nc = coeffs.length()
  if nc == 0 || n == 0 {
    return result
  }
  let re : Array[Double] = Array::make(nc, 0.0)
  let im : Array[Double] = Array::make(nc, 0.0)
  for i in 0..<nc {
    let (r, img) = coeffs[i]
    re[i] = r
    im[i] = img
  }
  fft(re, im, true)
  let count = if n < nc { n } else { nc }
  for i in 0..<count {
    result.push(@core.Point2D::new(re[i], im[i]))
  }
  result
}
