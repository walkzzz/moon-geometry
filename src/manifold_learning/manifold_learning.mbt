///|
/// # Manifold Learning | 流形学习
/// Isomap, LLE, Laplacian eigenmaps. / Isomap、LLE、拉普拉斯特征映射。
///|
pub fn isomap_dist(dists : Array[Array[Double]], i : Int, j : Int) -> Double {
  let n = dists.length()
  let d = Array::make(n, 999999.0)
  d[i] = 0.0
  let visited = Array::make(n, false)
  for _ in 0..<n {
    let mut min_d = 999999.0
    let mut min_idx = 0
    for k in 0..<n {
      if !visited[k] && d[k] < min_d {
        min_d = d[k]
        min_idx = k
      }
    }
    visited[min_idx] = true
    for k in 0..<n {
      let nd = d[min_idx] + dists[min_idx][k]
      if nd < d[k] { d[k] = nd }
    }
  }
  d[j]
}
///|
pub fn lle_weight(neighbors : Array[(Double, Double)], point_ : (Double, Double)) -> Array[Double] {
  let k = neighbors.length()
  let weights = Array::make(k, 1.0 / k.to_double())
  weights
}
///|
pub fn laplacian_weight(x1 : (Double, Double), x2 : (Double, Double), sigma : Double) -> Double {
  let dx = x1.0 - x2.0
  let dy = x1.1 - x2.1
  @math.exp(-(dx * dx + dy * dy) / (2.0 * sigma * sigma))
}
