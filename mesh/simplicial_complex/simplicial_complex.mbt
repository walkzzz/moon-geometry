///|
/// # Simplicial Complex
/// # 单纯复形
///
/// Simplicial complex data structure and validation.
/// 单纯复形数据结构与验证。

///|
pub struct SimplicialComplex {
  simplices : Array[Array[Int32]]
}

///|
pub fn SimplicialComplex::new(
  simplices : Array[Array[Int32]],
) -> SimplicialComplex {
  { simplices, }
}

///|
pub fn simplex_count(sc : SimplicialComplex) -> Int32 {
  sc.simplices.length()
}

///|
pub fn complex_dimension(sc : SimplicialComplex) -> Int32 {
  let mut max_dim = 0
  for i in 0..<sc.simplices.length() {
    let d = sc.simplices[i].length() - 1
    if d > max_dim {
      max_dim = d
    }
  }
  max_dim
}

///|
pub fn is_valid_complex(sc : SimplicialComplex) -> Bool {
  for i in 0..<sc.simplices.length() {
    let s = sc.simplices[i]
    let seen : Array[Int32] = []
    for j in 0..<s.length() {
      for k in 0..<seen.length() {
        if s[j] == seen[k] {
          return false
        }
      }
      seen.push(s[j])
    }
  }
  true
}

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
