///|
/// Uniform sampling inside a circle (rejection-free). / 在圆内均匀采样（无拒绝）。
pub fn circle_interior_sample(
  center : @core.Point2D,
  radius : Double,
  n : Int,
) -> Array[@core.Point2D] {
  let result : Array[@core.Point2D] = []
  for i in 0..<n {
    let angle = 2.0 * 3.141592653589793 * i.to_double() / n.to_double()
    let r = radius * (i.to_double() / n.to_double()).sqrt()
    result.push(@core.Point2D::new(center.x() + r * @math.cos(angle), center.y() + r * @math.sin(angle)))
  }
  result
}
