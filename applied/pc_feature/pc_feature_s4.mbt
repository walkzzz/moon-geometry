///|
/// Compute planarity feature. / 计算平面性特征。
pub fn planarity_feature(eigenvalues : Array[Double]) -> Double {
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
  (l2 - l3) / sum
}
