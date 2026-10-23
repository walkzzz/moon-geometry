///|
/// Robust left turn test. / 鲁棒左转判定。
pub fn robust_left_turn(
  a : @core.Point2D,
  b : @core.Point2D,
  c : @core.Point2D,
) -> Bool {
  robust_orientation(a, b, c) > 0
}
