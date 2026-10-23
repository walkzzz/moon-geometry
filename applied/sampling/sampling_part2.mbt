///|
/// Poisson-disk-like sampling (simplified grid-based). / 类泊松盘采样（基于网格的简化版）。
pub fn poisson_disk_sample(
  x_lo : Double,
  x_hi : Double,
  y_lo : Double,
  y_hi : Double,
  min_dist : Double,
) -> Array[@core.Point2D] {
  let result : Array[@core.Point2D] = []
  let step = min_dist
  let mut x = x_lo + step / 2.0
  let mut row = 0
  while x < x_hi {
    let y_offset = if row % 2 == 0 { 0.0 } else { step / 2.0 }
    let mut y = y_lo + step / 2.0 + y_offset
    while y < y_hi {
      result.push(@core.Point2D::new(x, y))
      y += step
    }
    x += step * 0.8660254037844387
    row += 1
  }
  result
}


///|
/// Sample points along a line segment. / 沿线段采样点。
pub fn segment_sample(
  p1 : @core.Point2D,
  p2 : @core.Point2D,
  n : Int,
) -> Array[@core.Point2D] {
  let result : Array[@core.Point2D] = []
  for i in 0..<n {
    let t = i.to_double() / (n - 1).to_double()
    result.push(@core.Point2D::new(p1.x() + t * (p2.x() - p1.x()), p1.y() + t * (p2.y() - p1.y())))
  }
  result
}
