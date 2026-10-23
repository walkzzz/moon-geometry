///|
/// Gaussian smooth a closed boundary (circular convolution).
/// 高斯平滑闭合边界（循环卷积）。
///
/// # Arguments / 参数
/// - `points`: boundary points / 边界点
/// - `sigma`: smoothing parameter / 平滑参数
pub fn gaussian_smooth(
  points : Array[@core.Point2D],
  sigma : Double,
) -> Array[@core.Point2D] {
  let n = points.length()
  let result : Array[@core.Point2D] = []
  if n == 0 {
    return result
  }
  if sigma < 0.000000000001 {
    for p in points {
      result.push(p)
    }
    return result
  }
  let radius = (3.0 * sigma).to_int() + 1
  let rad = if radius > n / 2 { n / 2 } else { radius }
  if rad < 1 {
    for p in points {
      result.push(p)
    }
    return result
  }
  let kernel = gaussian_kernel(sigma, rad)
  for i in 0..<n {
    let mut sx = 0.0
    let mut sy = 0.0
    for k in -rad..=rad {
      let j = ((i + k) % n + n) % n
      let w = kernel[k + rad]
      sx += w * points[j].x()
      sy += w * points[j].y()
    }
    result.push(@core.Point2D::new(sx, sy))
  }
  result
}
