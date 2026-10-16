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
fn gaussian_kernel(sigma : Double, radius : Int) -> Array[Double] {
  let kernel : Array[Double] = Array::make(2 * radius + 1, 0.0)
  let two_sigma_sq = 2.0 * sigma * sigma
  let mut sum = 0.0
  for i in -radius..=radius {
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

///|
/// Signed curvature at each point of a smoothed boundary.
/// 平滑边界各点的有符号曲率。
pub fn css_curvature(
  points : Array[@core.Point2D],
  sigma : Double,
) -> Array[Double] {
  let smoothed = gaussian_smooth(points, sigma)
  let n = smoothed.length()
  let result : Array[Double] = []
  if n < 3 {
    for _ in 0..<n {
      result.push(0.0)
    }
    return result
  }
  for i in 0..<n {
    let prev = smoothed[(i - 1 + n) % n]
    let curr = smoothed[i]
    let next = smoothed[(i + 1) % n]
    let dx1 = curr.x() - prev.x()
    let dy1 = curr.y() - prev.y()
    let dx2 = next.x() - curr.x()
    let dy2 = next.y() - curr.y()
    let cross = dx1 * dy2 - dy1 * dx2
    let len1 = (dx1 * dx1 + dy1 * dy1).sqrt()
    let len2 = (dx2 * dx2 + dy2 * dy2).sqrt()
    if len1 < 0.000000000001 || len2 < 0.000000000001 {
      result.push(0.0)
    } else {
      let len3 = ((next.x() - prev.x()) * (next.x() - prev.x()) +
        (next.y() - prev.y()) * (next.y() - prev.y())).sqrt()
      if len3 < 0.000000000001 {
        result.push(0.0)
      } else {
        result.push(2.0 * cross / (len1 * len2 * len3))
      }
    }
  }
  result
}

///|
/// Inflection point indices (curvature zero crossings) at given sigma.
/// 给定 sigma 下的拐点索引（曲率过零点）。
pub fn css_inflection_points(
  points : Array[@core.Point2D],
  sigma : Double,
) -> Array[Int] {
  let kappa = css_curvature(points, sigma)
  let n = kappa.length()
  let result : Array[Int] = []
  for i in 0..<n {
    let j = (i + 1) % n
    if kappa[i] * kappa[j] < 0.0 {
      if kappa[i].abs() < kappa[j].abs() {
        result.push(i)
      } else {
        result.push(j)
      }
    }
  }
  result
}

///|
/// CSS image: zero crossings across multiple sigma levels.
/// CSS 图像：多个 sigma 层的过零点。
///
/// # Arguments / 参数
/// - `points`: boundary points / 边界点
/// - `n_sigmas`: number of sigma levels / sigma 层数
///
/// Returns array of (sigma, inflection_point_index) pairs.
/// 返回 (sigma, 拐点索引) 对的数组。
pub fn css_image(
  points : Array[@core.Point2D],
  n_sigmas : Int,
) -> Array[(Double, Int)] {
  let result : Array[(Double, Int)] = []
  if n_sigmas <= 0 {
    return result
  }
  for level in 1..=n_sigmas {
    let sigma = level.to_double()
    let inflections = css_inflection_points(points, sigma)
    for idx in inflections {
      result.push((sigma, idx))
    }
  }
  result
}

///|
/// CSS maxima: sigma values where number of zero crossings is locally maximal.
/// CSS 极大值：过零点数局部极大处的 sigma 值。
pub fn css_maxima(
  points : Array[@core.Point2D],
  n_sigmas : Int,
) -> Array[Double] {
  let counts : Array[Int] = Array::make(n_sigmas + 2, 0)
  for level in 1..=n_sigmas {
    let sigma = level.to_double()
    counts[level] = css_inflection_points(points, sigma).length()
  }
  let result : Array[Double] = []
  for level in 1..=n_sigmas {
    if counts[level] >= counts[level - 1] && counts[level] >= counts[level + 1] {
      result.push(level.to_double())
    }
  }
  result
}