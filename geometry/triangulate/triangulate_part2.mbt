///|
/// Check if point p is strictly inside triangle (a, b, c).
/// 检查点 p 是否严格在三角形 (a, b, c) 内部。
fn point_in_triangle(
  p : @core.Point2D,
  a : @core.Point2D,
  b : @core.Point2D,
  c : @core.Point2D,
) -> Bool {
  let d1 = @core.turn(a, b, p)
  let d2 = @core.turn(b, c, p)
  let d3 = @core.turn(c, a, p)
  (d1 > 0.0 && d2 > 0.0 && d3 > 0.0) || (d1 < 0.0 && d2 < 0.0 && d3 < 0.0)
}
