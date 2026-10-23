///|
/// Project a point onto the plane. / 将点投影到平面。
pub fn Plane::project(plane : Plane, p : @core.Point3D) -> @core.Point3D {
  let dist = Plane::distance(plane, p)
  let nlen = (plane.normal.x * plane.normal.x +
  plane.normal.y * plane.normal.y +
  plane.normal.z * plane.normal.z).sqrt()
  if nlen < 0.000000000001 {
    return p
  }
  let nx = plane.normal.x / nlen
  let ny = plane.normal.y / nlen
  let nz = plane.normal.z / nlen
  @core.Point3D::new(p.x - dist * nx, p.y - dist * ny, p.z - dist * nz)
}
