///|
/// Ray-triangle intersection (Moller-Trumbore). Returns t >= 0 or None.
/// 射线与三角形相交（Moller-Trumbore）。返回 t >= 0 或 None。
pub fn ray_triangle_intersect(
  r : Ray3,
  v0 : @core.Point3D,
  v1 : @core.Point3D,
  v2 : @core.Point3D,
) -> Double? {
  let eps = 0.0000001
  let edge1 = v1.sub(v0)
  let edge2 = v2.sub(v0)
  let h = r.dir.cross(edge2)
  let a = edge1.dot(h)
  if a > -eps && a < eps {
    return None
  }
  let f = 1.0 / a
  let s = r.origin.sub(v0)
  let u = f * s.dot(h)
  if u < 0.0 || u > 1.0 {
    return None
  }
  let q = s.cross(edge1)
  let v = f * r.dir.dot(q)
  if v < 0.0 || u + v > 1.0 {
    return None
  }
  let t = f * edge2.dot(q)
  if t > eps {
    Some(t)
  } else {
    None
  }
}
