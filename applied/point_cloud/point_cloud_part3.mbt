///|
/// Grid downsampling: keep one point per voxel of given size. / 网格降采样：每体素保留一个点。
pub fn voxel_downsample(
  points : Array[@core.Point3D],
  voxel_size : Double,
) -> Array[@core.Point3D] {
  if voxel_size <= 0.0 || points.length() == 0 {
    return points
  }
  let result : Array[@core.Point3D] = []
  let seen : Array[(Int32, Int32, Int32)] = []
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
