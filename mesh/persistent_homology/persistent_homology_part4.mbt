///|
/// Compute persistence pairs via boundary matrix reduction (Z/2Z). / 通过边界矩阵约化计算持久对（Z/2Z）。
pub fn persistence_pairs(
  simplices : Array[SimplexWithFiltration],
) -> Array[(Int, Int)] {
  let n = simplices.length()
  if n == 0 {
    return []
  }
  let order = sort_by_filtration(simplices)
  let boundary : Array[Array[Int]] = Array::make(n, [])
  for j in 0..<n {
    let col : Array[Int] = []
    for i in 0..<n {
      if is_face(simplices[order[i]].vertices, simplices[order[j]].vertices) {
        col.push(i)
      }
    }
    boundary[j] = col
  }
  let lowest : Array[Int] = Array::make(n, -1)
  for j in 0..<n {
    if boundary[j].length() > 0 {
      let mut mx = boundary[j][0]
      for v in boundary[j] {
        if v > mx {
          mx = v
        }
      }
      lowest[j] = mx
    }
  }
  let pairs : Array[(Int, Int)] = []
  let reduced : Array[Array[Int]] = []
  for i in 0..<n {
    reduced.push(boundary[i].copy())
  }
  let low_map : Array[Int] = Array::make(n, -1)
  for j in 0..<n {
    while reduced[j].length() > 0 {
      let mut mx = reduced[j][0]
      for v in reduced[j] {
        if v > mx {
          mx = v
        }
      }
      let mut found_col = -1
      for k in 0..<j {
        if low_map[k] == mx {
          found_col = k
          break
        }
      }
      if found_col == -1 {
        low_map[j] = mx
        break
      }
      let new_col : Array[Int] = []
      for v in reduced[j] {
        let mut in_other = false
        for w in reduced[found_col] {
          if v == w {
            in_other = true
            break
          }
        }
        if !in_other {
          new_col.push(v)
        }
      }
      for v in reduced[found_col] {
        let mut in_main = false
        for w in reduced[j] {
          if v == w {
            in_main = true
            break
          }
        }
        if !in_main {
          new_col.push(v)
        }
      }
      reduced[j] = new_col
    }
  }
  for j in 0..<n {
    if low_map[j] != -1 {
      pairs.push((low_map[j], j))
    }
  }
  pairs
}

fn sort_by_filtration(
  simplices : Array[SimplexWithFiltration],
) -> Array[Int] {
  let n = simplices.length()
  let order = Array::make(n, 0)
  for i in 0..<n {
    order[i] = i
  }
  for i in 0..<(n - 1) {
    for j in 0..<(n - 1 - i) {
      let a = order[j]
      let b = order[j + 1]
      let fa = simplices[a].filtration
      let fb = simplices[b].filtration
      let da = simplex_dim(simplices[a])
      let db = simplex_dim(simplices[b])
      let should_swap = fa > fb || (fa == fb && da > db)
      if should_swap {
        order[j] = b
        order[j + 1] = a
      }
    }
  }
  order
}
