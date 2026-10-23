///|
pub fn add_simplex(sc : SimplicialComplex, vertices : Array[Int]) -> SimplicialComplex {
  let new_simplices : Array[Array[Int]] = []
  for i in 0..<sc.simplices.length() {
    new_simplices.push(sc.simplices[i])
  }
  new_simplices.push(vertices)
  { simplices: new_simplices, }
}
