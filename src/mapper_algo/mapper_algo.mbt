///|
/// # Mapper Algorithm
/// # Mapper 算法
///
/// Mapper algorithm for topological data analysis of point clouds.
/// 点云拓扑数据分析的 Mapper 算法。

///|
pub fn mapper_cover(values : Array[Double], n_intervals : Int, overlap : Double) -> Array[(Double, Double)] {
  if values.length() == 0 || n_intervals <= 0 { return [] }
  let mut lo = values[0]
  let mut hi = values[0]
  for i in 1..<values.length() {
    if values[i] < lo { lo = values[i] }
    if values[i] > hi { hi = values[i] }
  }
  let range = hi - lo
  if range < 0.000000000001 { return [(lo, hi)] }
  let step = range / n_intervals.to_double()
  let overlap_size = step * overlap
  let result : Array[(Double, Double)] = []
  for i in 0..<n_intervals {
    let start = lo + i.to_double() * step - overlap_size / 2.0
    let end = start + step + overlap_size
    result.push((start, end))
  }
  result
}

///|
pub fn mapper_cluster(points : Array[Double], interval : (Double, Double)) -> Array[Int] {
  let (lo, hi) = interval
  let result : Array[Int] = []
  for i in 0..<points.length() {
    if points[i] >= lo && points[i] <= hi {
      result.push(i)
    }
  }
  result
}

///|
pub fn mapper_graph_nodes(cover : Array[(Double, Double)], points : Array[Double]) -> Int {
  let mut count = 0
  for i in 0..<cover.length() {
    let cluster = mapper_cluster(points, cover[i])
    if cluster.length() > 0 { count += 1 }
  }
  count
}
