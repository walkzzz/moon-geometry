///|
pub fn add_simplex(
  sc : SimplicialComplex,
  vertices : Array[Int32],
) -> SimplicialComplex {
  let new_simplices : Array[Array[Int32]] = []
  for i in 0..<sc.simplices.length() {
    new_simplices.push(sc.simplices[i])
  }
  new_simplices.push(vertices)
  { simplices: new_simplices, }
}
