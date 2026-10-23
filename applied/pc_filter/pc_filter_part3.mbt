///|
/// Radius outlier removal: remove points with too few neighbors in radius.
/// 半径离群点去除：移除半径内邻居过少的点。
pub fn radius_filter(points : Array[@core.Point3D], radius : Double, min_neighbors : Int) -> Array[Int] {
  let n = points.length()
  let result : Array[Int] = []
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
pub fn removed_count(original : Int, kept : Int) -> Int {
  original - kept
}
