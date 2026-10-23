///|
/// Inverse stereographic projection from plane to sphere. / 从平面到球面的逆球极投影。
pub fn stereographic_to_sphere(
  p : @core.Point2D,
  radius : Double,
) -> @core.Point3D {
  let r2 = p.x() * p.x() + p.y() * p.y()
  let denom = 4.0 * radius * radius + r2
  let x = 4.0 * radius * radius * p.x() / denom
  let y = 4.0 * radius * radius * p.y() / denom
  let z = radius * (4.0 * radius * radius - r2) / denom
  @core.Point3D::new(x, y, z)
}

///|
/// Stereographic projection from south pole. / 从南极的球极投影。
pub fn stereographic_from_south(
  p : @core.Point3D,
  radius : Double,
) -> @core.Point2D? {
  let denom = radius + p.z
  if @core.approx_eq(denom, 0.0, 0.000000001) {
    return None
  }
  Some(
    @core.Point2D::new(2.0 * radius * p.x / denom, 2.0 * radius * p.y / denom),
  )
}
