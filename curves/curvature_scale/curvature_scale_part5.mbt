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
