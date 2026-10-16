///|
/// # Discrete Curvature
/// # 离散曲率
///
/// Discrete Gaussian and mean curvature on triangle meshes.
/// 三角网格上的离散高斯曲率和平均曲率。

///|
pub fn discrete_gaussian_curvature(angle_defect : Double) -> Double {
  angle_defect
}

///|
pub fn discrete_mean_curvature(area : Double, edge_lengths : Array[Double], dihedral_angles : Array[Double]) -> Double {
  let n = edge_lengths.length()
  if n == 0 || area < 0.000000000001 { return 0.0 }
  let mut sum = 0.0
  for i in 0..<n {
    sum += edge_lengths[i] * dihedral_angles[i]
  }
  sum / (4.0 * area)
}

///|
pub fn angle_defect(angles : Array[Double]) -> Double {
  let mut sum = 0.0
  for i in 0..<angles.length() {
    sum += angles[i]
  }
  6.283185307179586 - sum
}

///|
pub fn voronoi_area(edge_len : Double) -> Double {
  edge_len * edge_len / 8.0
}

///|
pub fn mixed_area(a1 : Double, a2 : Double) -> Double {
  (a1 + a2) / 2.0
}
