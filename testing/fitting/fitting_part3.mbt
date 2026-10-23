///|
/// Orthogonal distance regression (total least squares) line fit.
/// Minimizes perpendicular distances to the line.
/// Returns (a, b, c) for line ax + by + c = 0, normalized.
///
/// 正交距离回归（全最小二乘）直线拟合。
/// 最小化到直线的垂直距离。返回 (a, b, c) 满足 ax + by + c = 0。
pub fn fit_line_orthogonal(
  points : Array[@core.Point2D],
) -> (Double, Double, Double)? {
  let n = points.length()
  if n < 2 {
    return None
  }
  let nd = n.to_double()
  let mut mean_x = 0.0
  let mut mean_y = 0.0
  for p in points {
    mean_x += p.x()
    mean_y += p.y()
  }
  mean_x /= nd
  mean_y /= nd
  let mut sxx = 0.0
  let mut syy = 0.0
  let mut sxy = 0.0
  for p in points {
    let dx = p.x() - mean_x
    let dy = p.y() - mean_y
    sxx += dx * dx
    syy += dy * dy
    sxy += dx * dy
  }
  let theta = 0.5 * @math.atan2(2.0 * sxy, sxx - syy)
  let a = @math.sin(theta)
  let b = -@math.cos(theta)
  let c = -(a * mean_x + b * mean_y)
  Some((a, b, c))
}
