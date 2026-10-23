///|
/// Uniform sampling on a circle. / 在圆上均匀采样。
pub fn circle_sample(
  center : @core.Point2D,
  radius : Double,
  n : Int,
) -> Array[@core.Point2D] {
  let result : Array[@core.Point2D] = []
  for i in 0..<n {
    let angle = 2.0 * 3.141592653589793 * i.to_double() / n.to_double()
    result.push(@core.Point2D::new(center.x() + radius * @math.cos(angle), center.y() + radius * @math.sin(angle)))
  }
  result
}

