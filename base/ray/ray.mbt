///|
/// Ray type: origin + direction. / 射线类型：起点 + 方向。
pub struct Ray {
  origin : @core.Point2D
  dir : @core.Point2D
} derive(Debug)

///|
pub extend Ray with @moonbitlang/core/debug.Debug::{to_repr}

///|
/// Construct a ray from origin and direction. / 由起点和方向构造射线。
pub fn Ray::new(origin : @core.Point2D, dir : @core.Point2D) -> Ray {
  { origin, dir, }
}

///|
/// Construct a ray from two points (origin through target). / 由两点构造射线。
pub fn Ray::from_points(origin : @core.Point2D, through : @core.Point2D) -> Ray {
  {
    origin,
    dir: @core.Point2D::new(through.x() - origin.x(), through.y() - origin.y()),
  }
}

///|
/// Evaluate ray at parameter t (t >= 0). / 计算射线上参数 t 处的点。
pub fn Ray::eval(r : Ray, t : Double) -> @core.Point2D {
  @core.Point2D::new(r.origin.x() + r.dir.x() * t, r.origin.y() + r.dir.y() * t)
}
