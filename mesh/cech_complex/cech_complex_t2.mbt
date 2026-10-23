///|
pub fn cech_complex_simplices(n_points : Int, max_dim : Int) -> Array[Array[Int]] {
  let result : Array[Array[Int]] = []
  for d in 0..<(max_dim + 1) {
    if d + 1 <= n_points {
      let simplex : Array[Int] = []
      for i in 0..<(d + 1) {
        simplex.push(i)
      }
      result.push(simplex)
    }
  }
  result
}
