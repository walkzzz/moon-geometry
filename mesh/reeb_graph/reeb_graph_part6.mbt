///|
/// Union-find for component counting. / 用于分量计数的并查集。
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
