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
pub fn point_cloud_size(points : Array[@core.Point3D]) -> Int32 {
  points.length()
}
