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

///|
/// Check if a 3D point lies on a sphere of given radius. / 检查三维点是否在给定半径的球面上。
pub fn on_sphere(p : @core.Point3D, radius : Double) -> Bool {
  let r2 = p.x * p.x + p.y * p.y + p.z * p.z
  @core.approx_eq(r2, radius * radius, 0.0001)
}

///|
/// Compute the scale factor of stereographic projection at a point. / 计算球极投影在某点的缩放因子。
pub fn stereographic_scale(p : @core.Point3D, radius : Double) -> Double {
  let denom = radius - p.z
  if @core.approx_eq(denom, 0.0, 0.000000001) {
    return 0.0
  }
  2.0 * radius * radius / (denom * denom)
}
