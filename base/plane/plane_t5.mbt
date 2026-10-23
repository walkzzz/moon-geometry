///|
/// Normalize the plane normal to unit length. / 归一化平面法向量。
pub fn Plane::normalize(plane : Plane) -> Plane {
  let nlen = (plane.normal.x * plane.normal.x +
  plane.normal.y * plane.normal.y +
  plane.normal.z * plane.normal.z).sqrt()
  if nlen < 0.000000000001 {
    return plane
  }
  {
    normal: @core.Point3D::new(
      plane.normal.x / nlen,
      plane.normal.y / nlen,
      plane.normal.z / nlen,
    ),
    d: plane.d / nlen,
  }
}
