///|
pub fn complex_dimension(sc : SimplicialComplex) -> Int {
  let mut max_dim = 0
  for i in 0..<sc.simplices.length() {
    let d = sc.simplices[i].length() - 1
    if d > max_dim { max_dim = d }
  }
  max_dim
}
