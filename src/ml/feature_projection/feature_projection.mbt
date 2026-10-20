///|
/// # Feature Projection | 特征投影
/// PCA, LDA, and projection geometry. / PCA、LDA 投影几何。
///|
pub fn project_onto_line(point : (Double, Double), dir : (Double, Double)) -> Double {
  let norm = (dir.0 * dir.0 + dir.1 * dir.1).sqrt()
  if norm < 0.000000000001 { 0.0 } else { (point.0 * dir.0 + point.1 * dir.1) / norm }
}
///|
pub fn pca_1d_variance(projections : Array[Double]) -> Double {
  let n = projections.length().to_double()
  let mut mean = 0.0
  for i in 0..<projections.length() { mean += projections[i] }
  mean /= n
  let mut variance = 0.0
  for i in 0..<projections.length() {
    let d = projections[i] - mean
    variance += d * d
  }
  variance / n
}
///|
pub fn explained_variance_ratio(eigenvalues : Array[Double], k : Int) -> Double {
  let mut total = 0.0
  for i in 0..<eigenvalues.length() { total += eigenvalues[i] }
  let mut top = 0.0
  let kk = if k < eigenvalues.length() { k } else { eigenvalues.length() }
  for i in 0..<kk { top += eigenvalues[i] }
  if total.abs() < 0.000000000001 { 0.0 } else { top / total }
}
///|
pub fn projection_residual(point : (Double, Double), proj : (Double, Double)) -> Double {
  let dx = point.0 - proj.0
  let dy = point.1 - proj.1
  (dx * dx + dy * dy).sqrt()
}
