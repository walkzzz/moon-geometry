///|
/// Angle between two vectors in radians. / 两向量夹角（弧度）。
pub fn angle_between(a : @core.Point2D, b : @core.Point2D) -> Double {
  let la = length(a)
  let lb = length(b)
  if la < @core.default_eps || lb < @core.default_eps {
    return 0.0
  }
  let cos_val = (a.x() * b.x() + a.y() * b.y()) / (la * lb)
  if cos_val > 1.0 {
    0.0
  } else if cos_val < -1.0 {
    3.141592653589793
  } else {
    @math.acos(cos_val)
  }
}
