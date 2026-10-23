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