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
