///|
/// Compute local curvature feature (eigenvalue ratio). / 计算局部曲率特征（特征值比）。
pub fn curvature_feature(eigenvalues : Array[Double]) -> Double {
  if eigenvalues.length() < 3 {
    return 0.0
  }
  let l1 = eigenvalues[0]
  let l2 = eigenvalues[1]
  let l3 = eigenvalues[2]
  let sum = l1 + l2 + l3
  if sum < 0.000000000001 {
    return 0.0
  }
  l3 / sum
}
