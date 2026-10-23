///|
/// Ray-sphere intersection. Returns nearest t >= 0 or None.
/// 射线与球相交。返回最近 t >= 0 或 None。
pub fn ray_sphere_intersect(
  r : Ray3,
  center : @core.Point3D,
  radius : Double,
) -> Double? {
  let eps = 0.0000001
  let oc = r.origin.sub(center)
  let a = r.dir.dot(r.dir)
  let b = 2.0 * oc.dot(r.dir)
  let c = oc.dot(oc) - radius * radius
  let disc = b * b - 4.0 * a * c
  if disc < 0.0 {
    return None
  }
  let sq = disc.sqrt()
  let t1 = (-b - sq) / (2.0 * a)
  let t2 = (-b + sq) / (2.0 * a)
  if t1 > eps {
    Some(t1)
  } else if t2 > eps {
    Some(t2)
  } else {
    None
  }
}
