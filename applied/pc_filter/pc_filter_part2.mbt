///|
/// Statistical outlier removal: remove points whose mean neighbor distance is too large.
/// 统计离群点去除：移除平均邻距过大的点。
pub fn statistical_filter(points : Array[@core.Point3D], k : Int, threshold : Double) -> Array[Int] {
  let n = points.length()
  let result : Array[Int] = []
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
