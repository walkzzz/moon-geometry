///|
/// Check if point p lies on segment (a, b), assuming collinearity.
/// 在共线前提下检查点 p 是否在线段 (a, b) 上。
fn on_segment(a : @core.Point2D, b : @core.Point2D, p : @core.Point2D) -> Bool {
  let eps = @core.default_eps
  p.x <= (if a.x > b.x { a.x } else { b.x }) + eps &&
  p.x >= (if a.x < b.x { a.x } else { b.x }) - eps &&
  p.y <= (if a.y > b.y { a.y } else { b.y }) + eps &&
  p.y >= (if a.y < b.y { a.y } else { b.y }) - eps
}
