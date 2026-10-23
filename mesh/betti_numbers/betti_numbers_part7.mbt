///|
/// Compute b1 (number of tunnels/loops). / 计算 b1（隧道/环数）。
pub fn betti_1(simplices : Array[Array[Int]]) -> Int {
  let nv = count_vertices(simplices)
  let edges = collect_edges(simplices)
  let ne = edges.length()
  let triangles : Array[Array[Int]] = []
  for s in simplices {
    if s.length() == 3 {
      triangles.push(s)
    }
  }
  let nf = triangles.length()
  let b0 = betti_0(simplices)
  let rank1 = nv - b0
  let d2 : Array[Array[Int]] = Array::make(ne, Array::make(nf, 0))
  for fi in 0..<nf {
    let t = triangles[fi]
    let tri_edges = [
      (min2(t[0], t[1]), max2(t[0], t[1])),
      (min2(t[1], t[2]), max2(t[1], t[2])),
      (min2(t[2], t[0]), max2(t[2], t[0])),
    ]
    for te in tri_edges {
      for ei in 0..<ne {
        if edges[ei].0 == te.0 && edges[ei].1 == te.1 {
          d2[ei][fi] = 1
          break
        }
      }
    }
  }
  let rank2 = matrix_rank(d2)
  ne - rank1 - rank2
}
