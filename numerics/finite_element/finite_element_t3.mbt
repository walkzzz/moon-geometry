///|
pub fn apply_dirichlet(
  k : Array[Array[Double]],
  boundary_nodes : Array[Int32],
) -> Array[Array[Double]] {
  for i in 0..<boundary_nodes.length() {
    let idx = boundary_nodes[i]
    for j in 0..<k.length() {
      k[idx][j] = 0.0
      k[j][idx] = 0.0
    }
    k[idx][idx] = 1.0
  }
  k
}
