///|
/// Ray-plane intersection. Returns t >= 0 or None.
/// 射线与平面相交。返回 t >= 0 或 None。
pub fn ray_plane_intersect(
  r : Ray3,
  point : @core.Point3D,
  normal : @core.Point3D,
) -> Double? {
  let eps = 0.0000001
  let denom = r.dir.dot(normal)
  if denom > -eps && denom < eps {
    return None
  }
  let diff = point.sub(r.origin)
  let t = diff.dot(normal) / denom
  if t >= 0.0 {
    Some(t)
  } else {
    None
  }
}
