///|
/// # Dimension Reduction | 降维
/// t-SNE, UMAP geometry. / t-SNE、UMAP 几何。
///|
pub fn tsne_similarity(d_ij : Double, sigma : Double) -> Double {
  @math.exp(-d_ij * d_ij / (2.0 * sigma * sigma))
}
///|
pub fn tsne_normalize(sim : Array[Array[Double]]) -> Array[Array[Double]] {
  let n = sim.length()
  let mut total = 0.0
  for i in 0..<n {
    for j in 0..<n {
      if i != j { total += sim[i][j] }
    }
  }
  let result = []
  for i in 0..<n {
    let row = []
    for j in 0..<n {
      if total.abs() < 0.000000000001 { row.push(0.0) } else { row.push(sim[i][j] / total) }
    }
    result.push(row)
  }
  result
}
///|
pub fn umap_cross_entropy(p : Double, q : Double) -> Double {
  let eps = 0.0000000001
  let p_c = if p < eps { eps } else { if p > 1.0 - eps { 1.0 - eps } else { p } }
  let q_c = if q < eps { eps } else { if q > 1.0 - eps { 1.0 - eps } else { q } }
  p_c * @math.ln(p_c / q_c) + (1.0 - p_c) * @math.ln((1.0 - p_c) / (1.0 - q_c))
}
///|
pub fn kl_divergence(p : Array[Double], q : Array[Double]) -> Double {
  let n = if p.length() < q.length() { p.length() } else { q.length() }
  let mut sum = 0.0
  for i in 0..<n {
    if p[i] > 0.0 && q[i] > 0.0 {
      sum += p[i] * @math.ln(p[i] / q[i])
    }
  }
  sum
}
