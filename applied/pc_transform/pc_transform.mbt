///|
/// # Point Cloud Transform
/// # 点云变换
///
/// Rigid transformations for point clouds: translate, rotate, scale.
/// 点云的刚体变换：平移、旋转、缩放。


///|
/// Translate a point cloud. / 平移点云。
pub fn translate_cloud(points : Array[@core.Point3D], dx : Double, dy : Double, dz : Double) -> Array[@core.Point3D] {
  let result : Array[@core.Point3D] = []
  for i in 0..<points.length() {
    result.push(@core.Point3D::new(points[i].x + dx, points[i].y + dy, points[i].z + dz))
  }
  result
}
