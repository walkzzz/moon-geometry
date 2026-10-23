///|
/// Betti numbers result: b0 (components), b1 (loops), b2 (voids). / Betti 数结果：b0（连通分量）、b1（环）、b2（空洞）。
pub struct BettiResult {
  b0 : Int32
  b1 : Int32
  b2 : Int32
}

///|
/// Construct a Betti result. / 构造 Betti 结果。
pub fn BettiResult::new(b0 : Int32, b1 : Int32, b2 : Int32) -> BettiResult {
  { b0, b1, b2, }
}

///|
/// Union-find data structure for connected components. / 并查集数据结构，用于连通分量。
priv struct UnionFind {
  parent : Array[Int32]
  rank_ : Array[Int32]
}

///|
fn UnionFind::new(n : Int32) -> UnionFind {
  let parent = Array::make(n, 0)
  let rank_ = Array::make(n, 0)
  for i in 0..<n {
    parent[i] = i
  }
  { parent, rank_, }
}

///|
fn UnionFind::find(uf : UnionFind, x : Int32) -> Int32 {
  let mut root = x
  while uf.parent[root] != root {
    root = uf.parent[root]
  }
  let mut curr = x
  while uf.parent[curr] != root {
    let next = uf.parent[curr]
    uf.parent[curr] = root
    curr = next
  }
  root
}

///|
fn UnionFind::union(uf : UnionFind, x : Int32, y : Int32) -> Unit {
  let rx = uf.find(x)
  let ry = uf.find(y)
  if rx == ry {
    return
  }
  if uf.rank_[rx] < uf.rank_[ry] {
    uf.parent[rx] = ry
  } else if uf.rank_[rx] > uf.rank_[ry] {
    uf.parent[ry] = rx
  } else {
    uf.parent[ry] = rx
    uf.rank_[rx] += 1
  }
}

///|
/// Collect all edges from simplices (pairs of vertices). / 从单纯形中收集所有边（顶点对）。
fn collect_edges(simplices : Array[Array[Int32]]) -> Array[(Int32, Int32)] {
  let edges : Array[(Int32, Int32)] = []
  for s in simplices {
    let n = s.length()
    for i in 0..<n {
      for j in (i + 1)..<n {
        let (lo, hi) = if s[i] < s[j] { (s[i], s[j]) } else { (s[j], s[i]) }
        let mut found = false
        for e in edges {
          if e.0 == lo && e.1 == hi {
            found = true
            break
          }
        }
        if !found {
          edges.push((lo, hi))
        }
      }
    }
  }
  edges
}

///|
/// Count the maximum vertex index + 1. / 计算最大顶点索引 + 1。
fn count_vertices(simplices : Array[Array[Int32]]) -> Int32 {
  let mut max_v = -1
  for s in simplices {
    for v in s {
      if v > max_v {
        max_v = v
      }
    }
  }
  max_v + 1
}

///|
/// Compute b0 (number of connected components). / 计算 b0（连通分量数）。
pub fn betti_0(simplices : Array[Array[Int32]]) -> Int32 {
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

///|
/// Compute rank of boundary matrix over Z/2Z via Gaussian elimination. / 通过高斯消元计算边界矩阵在 Z/2Z 上的秩。
fn matrix_rank(matrix : Array[Array[Int32]]) -> Int32 {
  let rows = matrix.length()
  if rows == 0 {
    return 0
  }
  let cols = matrix[0].length()
  if cols == 0 {
    return 0
  }
  let mat = Array::make(rows, Array::make(cols, 0))
  for i in 0..<rows {
    for j in 0..<cols {
      mat[i][j] = matrix[i][j]
    }
  }
  let mut rank = 0
  for col in 0..<cols {
    let mut pivot = -1
    for row in rank..<rows {
      if mat[row][col] == 1 {
        pivot = row
        break
      }
    }
    if pivot == -1 {
      continue
    }
    if pivot != rank {
      for j in 0..<cols {
        let tmp = mat[rank][j]
        mat[rank][j] = mat[pivot][j]
        mat[pivot][j] = tmp
      }
    }
    for row in 0..<rows {
      if row != rank && mat[row][col] == 1 {
        for j in 0..<cols {
          mat[row][j] = (mat[row][j] + mat[rank][j]) % 2
        }
      }
    }
    rank += 1
    if rank >= rows {
      break
    }
  }
  rank
}

///|
/// Compute b1 (number of tunnels/loops). / 计算 b1（隧道/环数）。
pub fn betti_1(simplices : Array[Array[Int32]]) -> Int32 {
  let nv = count_vertices(simplices)
  let edges = collect_edges(simplices)
  let ne = edges.length()
  let triangles : Array[Array[Int32]] = []
  for s in simplices {
    if s.length() == 3 {
      triangles.push(s)
    }
  }
  let nf = triangles.length()
  let b0 = betti_0(simplices)
  let rank1 = nv - b0
  let d2 : Array[Array[Int32]] = Array::make(ne, Array::make(nf, 0))
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

///|
/// Compute b2 (number of voids/cavities). / 计算 b2（空洞/腔数）。
pub fn betti_2(simplices : Array[Array[Int32]]) -> Int32 {
  let edges = collect_edges(simplices)
  let ne = edges.length()
  let triangles : Array[Array[Int32]] = []
  for s in simplices {
    if s.length() == 3 {
      triangles.push(s)
    }
  }
  let nf = triangles.length()
  let d2 : Array[Array[Int32]] = Array::make(ne, Array::make(nf, 0))
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

///|
fn min2(a : Int32, b : Int32) -> Int32 {
  if a < b {
    a
  } else {
    b
  }
}

///|
fn max2(a : Int32, b : Int32) -> Int32 {
  if a > b {
    a
  } else {
    b
  }
}

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
