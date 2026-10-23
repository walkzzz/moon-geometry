///|
/// Compute axis-aligned bounding box of a point cloud. / 计算点云轴对齐包围盒。
pub fn point_cloud_aabb(
  points : Array[@core.Point3D],
) -> (@core.Point3D, @core.Point3D) {
  if points.length() == 0 {
    return (
      @core.Point3D::new(0.0, 0.0, 0.0),
      @core.Point3D::new(0.0, 0.0, 0.0),
    )
  }
  let mut min_x = points[0].x
  let mut min_y = points[0].y
  let mut min_z = points[0].z
  let mut max_x = points[0].x
  let mut max_y = points[0].y
  let mut max_z = points[0].z
  for i in 1..<points.length() {
    if points[i].x < min_x {
      min_x = points[i].x
    }
    if points[i].y < min_y {
      min_y = points[i].y
    }
    if points[i].z < min_z {
      min_z = points[i].z
    }
    if points[i].x > max_x {
      max_x = points[i].x
    }
    if points[i].y > max_y {
      max_y = points[i].y
    }
    if points[i].z > max_z {
      max_z = points[i].z
    }
  }
  (
    @core.Point3D::new(min_x, min_y, min_z),
    @core.Point3D::new(max_x, max_y, max_z),
  )
}
