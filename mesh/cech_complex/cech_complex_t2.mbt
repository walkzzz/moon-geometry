///|
pub fn cech_complex_simplices(
  n_points : Int32,
  max_dim : Int32,
) -> Array[Array[Int32]] {
  let result : Array[Array[Int32]] = []
  for d in 0..<(max_dim + 1) {
    if d + 1 <= n_points {
      let simplex : Array[Int32] = []
      for i in 0..<(d + 1) {
        simplex.push(i)
      }
      result.push(simplex)
    }
  }
  result
}
