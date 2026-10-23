///|
/// 3D ray: origin + direction. / 三维射线：起点 + 方向。
pub struct Ray3 {
  origin : @core.Point3D
  dir : @core.Point3D
}

///|
/// Construct a 3D ray. / 构造三维射线。
pub fn Ray3::new(origin : @core.Point3D, dir : @core.Point3D) -> Ray3 {
  { origin, dir, }
}

///|
/// Evaluate ray at parameter t. / 计算射线上参数 t 处的点。
pub fn ray_eval(r : Ray3, t : Double) -> @core.Point3D {
  @core.Point3D::new(
    r.origin.x + r.dir.x * t,
    r.origin.y + r.dir.y * t,
    r.origin.z + r.dir.z * t,
  )
}
