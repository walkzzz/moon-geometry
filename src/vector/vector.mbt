///|
/// Normalize a 2D vector to unit length. / 2D向量归一化。
pub fn normalize(v : @core.Point2D) -> @core.Point2D {
  let len = (v.x() * v.x() + v.y() * v.y()).sqrt()
  if len < @core.default_eps {
    return @core.Point2D::new(0.0, 0.0)
  }
  @core.Point2D::new(v.x() / len, v.y() / len)
}

///|
/// Reflect vector v across normal n. / 向量 v 关于法线 n 反射。
pub fn reflect(v : @core.Point2D, n : @core.Point2D) -> @core.Point2D {
  let dot = v.x() * n.x() + v.y() * n.y()
  @core.Point2D::new(v.x() - 2.0 * dot * n.x(), v.y() - 2.0 * dot * n.y())
}

///|
/// Project vector v onto vector u. / 向量 v 投影到向量 u。
pub fn project(v : @core.Point2D, u : @core.Point2D) -> @core.Point2D {
  let dot = v.x() * u.x() + v.y() * u.y()
  let len_sq = u.x() * u.x() + u.y() * u.y()
  if len_sq < @core.default_eps {
    return @core.Point2D::new(0.0, 0.0)
  }
  let t = dot / len_sq
  @core.Point2D::new(t * u.x(), t * u.y())
}

///|
/// Linear interpolation between a and b. / 线性插值。
pub fn lerp(a : @core.Point2D, b : @core.Point2D, t : Double) -> @core.Point2D {
  @core.Point2D::new(a.x() + (b.x() - a.x()) * t, a.y() + (b.y() - a.y()) * t)
}

///|
/// Perpendicular vector (rotated 90° CCW). / 垂直向量（逆时针旋转90°）。
pub fn perp(v : @core.Point2D) -> @core.Point2D {
  @core.Point2D::new(-v.y(), v.x())
}

///|
/// Vector length. / 向量长度。
pub fn length(v : @core.Point2D) -> Double {
  (v.x() * v.x() + v.y() * v.y()).sqrt()
}

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

///|
/// Reject component of v along u (v - project(v, u)). / 拒绝分量。
pub fn reject(v : @core.Point2D, u : @core.Point2D) -> @core.Point2D {
  let p = project(v, u)
  @core.Point2D::new(v.x() - p.x(), v.y() - p.y())
}