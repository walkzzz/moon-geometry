///|
/// Vector length. / 向量长度。
pub fn length(v : @core.Point2D) -> Double {
  (v.x() * v.x() + v.y() * v.y()).sqrt()
}
