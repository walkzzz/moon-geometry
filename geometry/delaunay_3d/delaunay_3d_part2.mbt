///|
/// Compute the signed volume of a tetrahedron. / 计算四面体的有符号体积。
pub fn tetrahedron_volume(
  a : @core.Point3D,
  b : @core.Point3D,
  c : @core.Point3D,
  d : @core.Point3D,
) -> Double {
  let ab = b.sub(a)
  let ac = c.sub(a)
  let ad = d.sub(a)
  ab.dot(ac.cross(ad)) / 6.0
}


///|
/// Compute the circumsphere center of a tetrahedron. / 计算四面体的外接球中心。
pub fn circumsphere_center(
  a : @core.Point3D,
  b : @core.Point3D,
  c : @core.Point3D,
  d : @core.Point3D,
) -> @core.Point3D {
  let ab = b.sub(a)
  let ac = c.sub(a)
  let ad = d.sub(a)
  let m00 = ab.dot(ab)
  let m01 = ab.dot(ac)
  let m02 = ab.dot(ad)
  let m10 = ac.dot(ab)
  let m11 = ac.dot(ac)
  let m12 = ac.dot(ad)
  let m20 = ad.dot(ab)
  let m21 = ad.dot(ac)
  let m22 = ad.dot(ad)
  let r0 = m00 * 0.5
  let r1 = m11 * 0.5
  let r2 = m22 * 0.5
  let det = m00 * (m11 * m22 - m12 * m21) - m01 * (m10 * m22 - m12 * m20) +
    m02 * (m10 * m21 - m11 * m20)
  if det.abs() < 0.0000000001 {
    return @core.Point3D::new(
      (a.x + b.x + c.x + d.x) / 4.0,
      (a.y + b.y + c.y + d.y) / 4.0,
      (a.z + b.z + c.z + d.z) / 4.0,
    )
  }
  let u = (r0 * (m11 * m22 - m12 * m21) - m01 * (r1 * m22 - m12 * r2) +
    m02 * (r1 * m21 - m11 * r2)) / det
  let v = (m00 * (r1 * m22 - m12 * r2) - r0 * (m10 * m22 - m12 * m20) +
    m02 * (m10 * r2 - r1 * m20)) / det
  let w = (m00 * (m11 * r2 - r1 * m21) - m01 * (m10 * r2 - r1 * m20) +
    r0 * (m10 * m21 - m11 * m20)) / det
  a.add(ab.mul(u)).add(ac.mul(v)).add(ad.mul(w))
}


///|
/// Compute the squared circumsphere radius of a tetrahedron. / 计算四面体外接球半径平方。
pub fn circumsphere_radius_sq(
  a : @core.Point3D,
  b : @core.Point3D,
  c : @core.Point3D,
  d : @core.Point3D,
) -> Double {
  let center = circumsphere_center(a, b, c, d)
  center.dist_sq(a)
}


///|
/// Check if a point is inside the circumsphere of a tetrahedron. / 检查点是否在四面体的外接球内。
pub fn in_circumsphere(
  p : @core.Point3D,
  a : @core.Point3D,
  b : @core.Point3D,
  c : @core.Point3D,
  d : @core.Point3D,
) -> Bool {
  let center = circumsphere_center(a, b, c, d)
  let radius_sq = center.dist_sq(a)
  center.dist_sq(p) < radius_sq - 0.0000000001
}
