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

///|
/// Compute axis-aligned bounding box of a point cloud. / 计算点云轴对齐包围盒。
pub fn point_cloud_aabb(points : Array[@core.Point3D]) -> (@core.Point3D, @core.Point3D) {
  if points.length() == 0 {
    return (@core.Point3D::new(0.0, 0.0, 0.0), @core.Point3D::new(0.0, 0.0, 0.0))
  }
  let mut min_x = points[0].x
  let mut min_y = points[0].y
  let mut min_z = points[0].z
  let mut max_x = points[0].x
  let mut max_y = points[0].y
  let mut max_z = points[0].z
  for i in 1..<points.length() {
    if points[i].x < min_x { min_x = points[i].x }
    if points[i].y < min_y { min_y = points[i].y }
    if points[i].z < min_z { min_z = points[i].z }
    if points[i].x > max_x { max_x = points[i].x }
    if points[i].y > max_y { max_y = points[i].y }
    if points[i].z > max_z { max_z = points[i].z }
  }
  (@core.Point3D::new(min_x, min_y, min_z), @core.Point3D::new(max_x, max_y, max_z))
}

///|
/// Grid downsampling: keep one point per voxel of given size. / 网格降采样：每体素保留一个点。
pub fn voxel_downsample(points : Array[@core.Point3D], voxel_size : Double) -> Array[@core.Point3D] {
  if voxel_size <= 0.0 || points.length() == 0 {
    return points
  }
  let result : Array[@core.Point3D] = []
  let seen : Array[(Int, Int, Int)] = []
  for i in 0..<points.length() {
    let key = (
      (points[i].x / voxel_size).floor().to_int(),
      (points[i].y / voxel_size).floor().to_int(),
      (points[i].z / voxel_size).floor().to_int(),
    )
    let mut found = false
    for j in 0..<seen.length() {
      if seen[j].0 == key.0 && seen[j].1 == key.1 && seen[j].2 == key.2 {
        found = true
        break
      }
    }
    if !found {
      seen.push(key)
      result.push(points[i])
    }
  }
  result
}

///|
/// Compute average nearest-neighbor distance. / 计算平均最近邻距离。
pub fn avg_nearest_neighbor_dist(points : Array[@core.Point3D]) -> Double {
  let n = points.length()
  if n < 2 {
    return 0.0
  }
  let mut total = 0.0
  for i in 0..<n {
    let mut min_dist = 999999999.0
    for j in 0..<n {
      if i != j {
        let d = points[i].dist(points[j])
        if d < min_dist {
          min_dist = d
        }
      }
    }
    total += min_dist
  }
  total / n.to_double()
}

///|
/// Point cloud size. / 点云大小。
pub fn point_cloud_size(points : Array[@core.Point3D]) -> Int {
  points.length()
}
