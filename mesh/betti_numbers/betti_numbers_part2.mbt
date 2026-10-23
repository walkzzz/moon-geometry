///|
/// Union-find data structure for connected components. / 并查集数据结构，用于连通分量。
priv struct UnionFind {
  parent : Array[Int]
  rank_ : Array[Int]
}

fn UnionFind::new(n : Int) -> UnionFind {
  let parent = Array::make(n, 0)
  let rank_ = Array::make(n, 0)
  for i in 0..<n {
    parent[i] = i
  }
  { parent, rank_ }
}

fn UnionFind::find(uf : UnionFind, x : Int) -> Int {
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

fn UnionFind::union(uf : UnionFind, x : Int, y : Int) -> Unit {
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
