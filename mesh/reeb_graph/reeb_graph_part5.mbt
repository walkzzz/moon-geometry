///|
/// Count connected components of lower/upper link. / 计算下/上链接的连通分量数。
fn count_components(
  v : Int,
  adj : Array[Array[Int]],
  values : Array[Double],
  lower : Bool,
) -> Int {
  let neighbors : Array[Int] = []
  for j in adj[v] {
    if lower && values[j] < values[v] - 0.0000000001 {
      neighbors.push(j)
    }
    if !lower && values[j] > values[v] + 0.0000000001 {
      neighbors.push(j)
    }
  }
  if neighbors.length() == 0 {
    return 0
  }
  let neighbor_set : Array[Int] = Array::make(values.length(), -1)
  for idx in 0..<neighbors.length() {
    neighbor_set[neighbors[idx]] = idx
  }
  let uf = UnionFind::new(neighbors.length())
  for a in 0..<neighbors.length() {
    for b in (a + 1)..<neighbors.length() {
      let na = neighbors[a]
      let nb = neighbors[b]
      for e in adj[na] {
        if e == nb {
          uf.union(a, b)
          break
        }
      }
    }
  }
  let mut components = 0
  for i in 0..<neighbors.length() {
    if uf.find(i) == i {
      components += 1
    }
  }
  components
}
