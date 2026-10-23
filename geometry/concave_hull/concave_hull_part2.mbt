///|
/// Compute concave hull with default k value. / 使用默认 k 值计算凹包。
pub fn concave_hull_default(
  points : Array[@core.Point2D],
) -> Array[@core.Point2D] {
  concave_hull(points, 3)
}
