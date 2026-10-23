///|
/// Check if bottleneck distance <= threshold. / 检查瓶颈距离是否 <= 阈值。
pub fn bottleneck_within(
  a : Array[@core.Point2D],
  b : Array[@core.Point2D],
  threshold : Double,
) -> Bool {
  bottleneck_distance(a, b) <= threshold
}
