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
