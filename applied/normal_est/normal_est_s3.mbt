///|
/// Normalize a 3D vector to unit length. / 归一化3D向量。
pub fn normalize_normal(n : @core.Point3D) -> @core.Point3D {
  let len = (n.x * n.x + n.y * n.y + n.z * n.z).sqrt()
  if len < 0.000000000001 {
    return @core.Point3D::new(0.0, 0.0, 1.0)
  }
  @core.Point3D::new(n.x / len, n.y / len, n.z / len)
}

///|
/// Flip normal to point towards a reference direction. / 翻转法线使其朝向参考方向。
pub fn orient_normal(
  normal : @core.Point3D,
  ref_dir : @core.Point3D,
) -> @core.Point3D {
  let dot = normal.x * ref_dir.x + normal.y * ref_dir.y + normal.z * ref_dir.z
  if dot < 0.0 {
    @core.Point3D::new(-normal.x, -normal.y, -normal.z)
  } else {
    normal
  }
}
