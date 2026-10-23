///|
/// Compute b0 (number of connected components). / 计算 b0（连通分量数）。
pub fn betti_0(simplices : Array[Array[Int]]) -> Int {
  let nv = count_vertices(simplices)
  if nv == 0 {
    return 0
  }
  let uf = UnionFind::new(nv)
  let edges = collect_edges(simplices)
  for e in edges {
    uf.union(e.0, e.1)
  }
  let mut components = 0
  for i in 0..<nv {
    if uf.find(i) == i {
      components += 1
    }
  }
  components
}
