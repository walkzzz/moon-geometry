///|
/// # Simplicial Complex
/// # 单纯复形
///
/// Simplicial complex data structure and validation.
/// 单纯复形数据结构与验证。


///|
pub struct SimplicialComplex {
  simplices : Array[Array[Int]]
}


///|
pub fn SimplicialComplex::new(simplices : Array[Array[Int]]) -> SimplicialComplex {
  { simplices, }
}


///|
pub fn simplex_count(sc : SimplicialComplex) -> Int {
  sc.simplices.length()
}
