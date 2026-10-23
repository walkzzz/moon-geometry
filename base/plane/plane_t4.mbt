///|
/// Intersection of a plane and a 3D ray (origin + t*dir). Returns t or None. / 平面与三维射线交点。
pub fn Plane::line_intersect(
  plane : Plane,
  origin : @core.Point3D,
  dir : @core.Point3D,
) -> @core.Point3D? {
  let denom = plane.normal.x * dir.x +
    plane.normal.y * dir.y +
    plane.normal.z * dir.z
  if @core.approx_eq(denom, 0.0, 0.000000000001) {
    return None
  }
  let t = -(plane.normal.x * origin.x +
    plane.normal.y * origin.y +
    plane.normal.z * origin.z +
    plane.d) /
    denom
  Some(
    @core.Point3D::new(
      origin.x + dir.x * t,
      origin.y + dir.y * t,
      origin.z + dir.z * t,
    ),
  )
}
