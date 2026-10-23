///|
/// Compute all Betti numbers. / 计算所有 Betti 数。
pub fn betti_numbers(simplices : Array[Array[Int32]]) -> BettiResult {
  let b0 = betti_0(simplices)
  let b1 = betti_1(simplices)
  let b2 = betti_2(simplices)
  { b0, b1, b2, }
}

///|
/// Compute the Euler characteristic from simplices. / 由单纯形计算欧拉示性数。
pub fn compute_euler(simplices : Array[Array[Int32]]) -> Int32 {
  let nv = count_vertices(simplices)
  let edges = collect_edges(simplices)
  let ne = edges.length()
  let mut nf = 0
  for s in simplices {
    if s.length() == 3 {
      nf += 1
    }
  }
  nv - ne + nf
}
