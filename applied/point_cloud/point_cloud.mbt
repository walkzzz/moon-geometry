///|
/// # Point Cloud Processing
/// # 点云处理
///
/// Basic point cloud operations: downsampling, bounding box, centroid.
/// 点云基础操作：降采样、包围盒、质心。


///|
/// Compute centroid of a 3D point cloud. / 计算3D点云质心。
pub fn point_cloud_centroid(points : Array[@core.Point3D]) -> @core.Point3D {
  let n = points.length()
  if n == 0 {
    return @core.Point3D::new(0.0, 0.0, 0.0)
  }
  let mut sx = 0.0
  let mut sy = 0.0
  let mut sz = 0.0
  for i in 0..<n {
    sx += points[i].x
    sy += points[i].y
    sz += points[i].z
  }
  let inv = 1.0 / n.to_double()
  @core.Point3D::new(sx * inv, sy * inv, sz * inv)
}
