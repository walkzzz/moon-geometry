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
