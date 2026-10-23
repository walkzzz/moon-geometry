///|
/// # Point Cloud Transform
/// # 点云变换
///
/// Rigid transformations for point clouds: translate, rotate, scale.
/// 点云的刚体变换：平移、旋转、缩放。

///|
/// Translate a point cloud. / 平移点云。
pub fn translate_cloud(
  points : Array[@core.Point3D],
  dx : Double,
  dy : Double,
  dz : Double,
) -> Array[@core.Point3D] {
  let result : Array[@core.Point3D] = []
  for i in 0..<points.length() {
    result.push(
      @core.Point3D::new(points[i].x + dx, points[i].y + dy, points[i].z + dz),
    )
  }
  result
}

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

///|
/// Center point cloud at origin (subtract centroid). / 将点云居中至原点。
pub fn center_cloud(points : Array[@core.Point3D]) -> Array[@core.Point3D] {
  let n = points.length()
  if n == 0 {
    return points
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
  translate_cloud(points, -sx * inv, -sy * inv, -sz * inv)
}
