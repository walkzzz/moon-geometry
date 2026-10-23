///|
/// Signed distance from point to plane. / 点到平面的有符号距离。
pub fn Plane::distance(plane : Plane, p : @core.Point3D) -> Double {
  let nlen = (plane.normal.x * plane.normal.x +
  plane.normal.y * plane.normal.y +
  plane.normal.z * plane.normal.z).sqrt()
  if nlen < 0.000000000001 {
    return 0.0
  }
  (plane.normal.x * p.x + plane.normal.y * p.y + plane.normal.z * p.z + plane.d) /
  nlen
}
