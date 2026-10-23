///|
/// Compute b2 (number of voids/cavities). / 计算 b2（空洞/腔数）。
pub fn betti_2(simplices : Array[Array[Int]]) -> Int {
  let edges = collect_edges(simplices)
  let ne = edges.length()
  let triangles : Array[Array[Int]] = []
  for s in simplices {
    if s.length() == 3 {
      triangles.push(s)
    }
  }
  let nf = triangles.length()
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
  nf - rank2
}

fn min2(a : Int, b : Int) -> Int {
  if a < b {
    a
  } else {
    b
  }
}

fn max2(a : Int, b : Int) -> Int {
  if a > b {
    a
  } else {
    b
  }
}
