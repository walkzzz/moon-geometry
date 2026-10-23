///|
/// Ray-triangle intersection (Moller-Trumbore). / 射线-三角形相交（Moller-Trumbore）。
fn ray_triangle_intersect(
  origin : @core.Point3D,
  dir : @core.Point3D,
  v0 : @core.Point3D,
  v1 : @core.Point3D,
  v2 : @core.Point3D,
) -> Bool {
  let eps = 0.0000000001
  let edge1 = v1.sub(v0)
  let edge2 = v2.sub(v0)
  let h = dir.cross(edge2)
  let a = edge1.dot(h)
  if a.abs() < eps {
    return false
  }
  let f = 1.0 / a
  let s = origin.sub(v0)
  let u = f * s.dot(h)
  if u < 0.0 || u > 1.0 {
    return false
  }
  let q = s.cross(edge1)
  let v = f * dir.dot(q)
  if v < 0.0 || u + v > 1.0 {
    return false
  }
  let t = f * edge2.dot(q)
  t > eps
}
