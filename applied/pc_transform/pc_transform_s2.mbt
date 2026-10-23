///|
/// Scale a point cloud. / 缩放点云。
pub fn scale_cloud(
  points : Array[@core.Point3D],
  factor : Double,
) -> Array[@core.Point3D] {
  let result : Array[@core.Point3D] = []
  for i in 0..<points.length() {
    result.push(
      @core.Point3D::new(
        points[i].x * factor,
        points[i].y * factor,
        points[i].z * factor,
      ),
    )
  }
  result
}

///|
/// Rotate point cloud around Z axis. / 绕Z轴旋转点云。
pub fn rotate_z_cloud(
  points : Array[@core.Point3D],
  angle : Double,
) -> Array[@core.Point3D] {
  let cos_a = @math.cos(angle)
  let sin_a = @math.sin(angle)
  let result : Array[@core.Point3D] = []
  for i in 0..<points.length() {
    let x = points[i].x * cos_a - points[i].y * sin_a
    let y = points[i].x * sin_a + points[i].y * cos_a
    result.push(@core.Point3D::new(x, y, points[i].z))
  }
  result
}
