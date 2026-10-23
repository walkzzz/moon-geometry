///|
/// # Normal Estimation
/// # 法线估计
///
/// Estimate surface normals from point cloud neighborhoods via PCA.
/// 通过 PCA 从点云邻域估计曲面法线。

///|
/// Estimate normal at a point using PCA on its k-nearest neighbors.
/// 用 PCA 在 k 近邻上估计法线。
pub fn estimate_normal(
  center : @core.Point3D,
  neighbors : Array[@core.Point3D],
) -> @core.Point3D {
  let n = neighbors.length()
  if n == 0 {
    return @core.Point3D::new(0.0, 0.0, 1.0)
  }
  let mut cxx = 0.0
  let mut cyy = 0.0
  let mut czz = 0.0
  for i in 0..<n {
    let dx = neighbors[i].x - center.x
    let dy = neighbors[i].y - center.y
    let dz = neighbors[i].z - center.z
    cxx += dx * dx
    cyy += dy * dy
    czz += dz * dz
  }
  let trace = cxx + cyy + czz
  if trace < 0.000000000001 {
    return @core.Point3D::new(0.0, 0.0, 1.0)
  }
  let mut min_val = cxx
  let mut min_axis = 0
  if cyy < min_val {
    min_val = cyy
    min_axis = 1
  }
  if czz < min_val {
    min_val = czz
    min_axis = 2
  }
  match min_axis {
    0 => @core.Point3D::new(1.0, 0.0, 0.0)
    1 => @core.Point3D::new(0.0, 1.0, 0.0)
    _ => @core.Point3D::new(0.0, 0.0, 1.0)
  }
}

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
