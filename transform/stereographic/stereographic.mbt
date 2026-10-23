///|
/// Stereographic projection from sphere to plane (north pole). / 从球面到平面的球极投影（北极）。
pub fn stereographic_from_sphere(
  p : @core.Point3D,
  radius : Double,
) -> @core.Point2D? {
  let np = @core.Point3D::new(0.0, 0.0, radius)
  if @core.approx_eq(p.dist(np), 0.0, 0.000000001) {
    return None
  }
  let denom = radius - p.z
  if @core.approx_eq(denom, 0.0, 0.000000001) {
    return None
  }
  Some(
    @core.Point2D::new(2.0 * radius * p.x / denom, 2.0 * radius * p.y / denom),
  )
}
