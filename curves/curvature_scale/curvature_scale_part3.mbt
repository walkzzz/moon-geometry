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
