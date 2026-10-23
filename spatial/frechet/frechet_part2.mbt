///|
/// Check if Fréchet distance <= epsilon. / 检查 Fréchet 距离是否 <= epsilon。
pub fn frechet_within(
  c1 : Array[@core.Point2D],
  c2 : Array[@core.Point2D],
  eps : Double,
) -> Bool {
  frechet_distance(c1, c2) <= eps
}


///|
/// Fréchet distance between two single points. / 两个单点的 Fréchet 距离。
pub fn frechet_point_distance(
  p1 : @core.Point2D,
  p2 : @core.Point2D,
) -> Double {
  p1.dist(p2)
}