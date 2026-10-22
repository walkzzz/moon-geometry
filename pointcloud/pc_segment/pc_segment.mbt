///|
/// # Point Cloud Segmentation
/// # 点云分割
///
/// Region growing and plane segmentation for point clouds.
/// 点云的区域生长和平面分割。

///|
/// Segment points by Z-value threshold (ground vs non-ground). / 按Z值阈值分割点云。
pub fn segment_by_height(points : Array[@core.Point3D], threshold : Double) -> (Array[Int], Array[Int]) {
  let ground : Array[Int] = []
  let non_ground : Array[Int] = []
  for i in 0..<points.length() {
    if points[i].z < threshold {
      ground.push(i)
    } else {
      non_ground.push(i)
    }
  }
  (ground, non_ground)
}

///|
/// Segment points into clusters by distance. / 按距离将点云分割为簇。
pub fn segment_by_distance(points : Array[@core.Point3D], max_dist : Double) -> Array[Array[Int]] {
  let n = points.length()
  if n == 0 {
    return []
  }
  let labels : Array[Int] = Array::make(n, -1)
  let mut current_label = 0
  for i in 0..<n {
    if labels[i] != -1 {
      continue
    }
    labels[i] = current_label
    let queue : Array[Int] = [i]
    while queue.length() > 0 {
      let idx = queue.remove(queue.length() - 1)

      for j in 0..<n {
        if labels[j] == -1 && points[idx].dist(points[j]) < max_dist {
          labels[j] = current_label
          queue.push(j)
        }
      }
    }
    current_label += 1
  }
  let clusters : Array[Array[Int]] = []
  for l in 0..<current_label {
    let cluster : Array[Int] = []
    for i in 0..<n {
      if labels[i] == l {
        cluster.push(i)
      }
    }
    clusters.push(cluster)
  }
  clusters
}

///|
/// Count segments. / 分割段数。
pub fn segment_count(clusters : Array[Array[Int]]) -> Int {
  clusters.length()
}
