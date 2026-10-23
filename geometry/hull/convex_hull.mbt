///|

///|
/// Three-point orientation test.
/// 三点方向判定。
/// Returns @core.CounterClockwise, @core.Clockwise, or @core.Collinear.
pub fn ccw(
  a : @core.Point2D,
  b : @core.Point2D,
  c : @core.Point2D,
) -> @core.Orientation {
  let cr = (b.x - a.x) * (c.y - a.y) - (b.y - a.y) * (c.x - a.x)
  if cr > 0.0 {
    @core.CounterClockwise
  } else if cr < 0.0 {
    @core.Clockwise
  } else {
    @core.Collinear
  }
}
