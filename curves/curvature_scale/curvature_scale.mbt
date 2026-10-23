///|
/// # Curvature Scale Space (CSS)
/// # 曲率尺度空间
///
/// Gaussian smoothing of a closed boundary, curvature zero-crossing detection.
/// 闭合边界的高斯平滑、曲率过零点检测。
///
/// ## Complexity: O(n^2) per sigma level
/// ## 复杂度: 每个 sigma 层 O(n^2)

///|
/// Gaussian kernel weights for given sigma and window size.
/// 给定 sigma 和窗口大小的高斯核权重。
fn gaussian_kernel(sigma : Double, radius : Int32) -> Array[Double] {
  let kernel : Array[Double] = Array::make(2 * radius + 1, 0.0)
  let two_sigma_sq = 2.0 * sigma * sigma
  let mut sum = 0.0
  for i in -radius..<=radius {
    let w = @math.exp(i.to_double() * i.to_double() / -two_sigma_sq)
    kernel[i + radius] = w
    sum += w
  }
  if sum > 0.000000000001 {
    for i in 0..<(2 * radius + 1) {
      kernel[i] = kernel[i] / sum
    }
  }
  kernel
}
