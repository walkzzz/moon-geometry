///|
/// Generate random points on a circle. / 在圆上生成随机点。
pub fn Rng::random_points_on_circle(
  r : Rng,
  n : Int,
  center : @core.Point2D,
  radius : Double,
) -> Array[@core.Point2D] {
  let result : Array[@core.Point2D] = []
  for _ in 0..<n {
    let angle = r.range_double(0.0, 6.283185307179586)
    result.push(@core.Point2D::new(center.x() + radius * @math.cos(angle), center.y() + radius * @math.sin(angle)))
  }
  result
}