///|
/// Check if a point is in the half-plane. / 检查点是否在半平面内。
pub fn HalfPlane::contains(hp : HalfPlane, p : @core.Point2D) -> Bool {
  hp.a * p.x() + hp.b * p.y() + hp.c <= 0.0
}

///|
/// Evaluate the signed value at a point. / 计算点处的有符号值。
pub fn HalfPlane::eval(hp : HalfPlane, p : @core.Point2D) -> Double {
  hp.a * p.x() + hp.b * p.y() + hp.c
}
