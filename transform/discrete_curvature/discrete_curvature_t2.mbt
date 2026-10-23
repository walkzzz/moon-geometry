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
