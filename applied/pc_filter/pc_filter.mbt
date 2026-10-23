///|
/// # Point Cloud Filtering
/// # 点云滤波
///
/// Statistical and radius-based outlier removal for point clouds.
/// 点云的统计滤波和半径滤波去除离群点。

///|
/// Statistical outlier removal: remove points whose mean neighbor distance is too large.
/// 统计离群点去除：移除平均邻距过大的点。
pub fn statistical_filter(
  points : Array[@core.Point3D],
  k : Int32,
  threshold : Double,
) -> Array[Int32] {
  let n = points.length()
  let result : Array[Int32] = []
  for i in 0..<n {
    let dists : Array[Double] = []
    for j in 0..<n {
      if i != j {
        dists.push(points[i].dist(points[j]))
      }
    }
    dists.sort()
    let kk = if k < dists.length() { k } else { dists.length() }
    let mut sum = 0.0
    for d in 0..<kk {
      sum += dists[d]
    }
    let mean = if kk > 0 { sum / kk.to_double() } else { 0.0 }
    if mean < threshold {
      result.push(i)
    }
  }
  result
}

///|
/// Radius outlier removal: remove points with too few neighbors in radius.
/// 半径离群点去除：移除半径内邻居过少的点。
pub fn radius_filter(
  points : Array[@core.Point3D],
  radius : Double,
  min_neighbors : Int32,
) -> Array[Int32] {
  let n = points.length()
  let result : Array[Int32] = []
  for i in 0..<n {
    let mut count = 0
    for j in 0..<n {
      if i != j && points[i].dist(points[j]) < radius {
        count += 1
      }
    }
    if count >= min_neighbors {
      result.push(i)
    }
  }
  result
}

///|
/// Count removed points. / 被移除点计数。
pub fn removed_count(original : Int32, kept : Int32) -> Int32 {
  original - kept
}
