///|
/// # Geometric Clustering | 几何聚类
/// K-means, DBSCAN geometry. / K-means、DBSCAN 几何。
///|
pub fn kmeans_assign(point : (Double, Double), centroids : Array[(Double, Double)]) -> Int {
  let mut min_dist = 999999.0
  let mut min_idx = 0
  for i in 0..<centroids.length() {
    let dx = point.0 - centroids[i].0
    let dy = point.1 - centroids[i].1
    let d = dx * dx + dy * dy
    if d < min_dist { min_dist = d; min_idx = i }
  }
  min_idx
}
///|
pub fn kmeans_update(points : Array[(Double, Double)], assignments : Array[Int], k : Int) -> Array[(Double, Double)] {
  let centroids = Array::make(k, (0.0, 0.0))
  let counts = Array::make(k, 0)
  for i in 0..<points.length() {
    let c = assignments[i]
    if c < k {
      centroids[c] = (centroids[c].0 + points[i].0, centroids[c].1 + points[i].1)
      counts[c] += 1
    }
  }
  for i in 0..<k {
    if counts[i] > 0 {
      centroids[i] = (centroids[i].0 / counts[i].to_double(), centroids[i].1 / counts[i].to_double())
    }
  }
  centroids
}
///|
pub fn dbscan_eps_neighbors(points : Array[(Double, Double)], idx : Int, eps : Double) -> Array[Int] {
  let neighbors = []
  for i in 0..<points.length() {
    if i != idx {
      let dx = points[i].0 - points[idx].0
      let dy = points[i].1 - points[idx].1
      if (dx * dx + dy * dy).sqrt() <= eps { neighbors.push(i) }
    }
  }
  neighbors
}
///|
pub fn silhouette_score(a : Double, b : Double) -> Double {
  let max_ab = if a > b { a } else { b }
  if max_ab.abs() < 0.000000000001 { 0.0 } else { (b - a) / max_ab }
}
