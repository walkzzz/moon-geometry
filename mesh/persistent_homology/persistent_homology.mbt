///|
/// A persistence barcode: birth, death, and dimension. / 持久同调条形码：出生、死亡和维度。
pub struct Barcode {
  birth : Double
  death : Double
  dimension : Int32
}

///|
/// Construct a barcode. / 构造条形码。
pub fn Barcode::new(
  birth : Double,
  death : Double,
  dimension : Int32,
) -> Barcode {
  { birth, death, dimension, }
}

///|
/// Check if the barcode is infinite (death is infinity). / 检查条形码是否为无穷（死亡值为无穷）。
pub fn Barcode::is_infinite(self : Barcode) -> Bool {
  self.death >= 999999999.0
}

///|
/// A simplex with its filtration value. / 带过滤值的单纯形。
pub struct SimplexWithFiltration {
  vertices : Array[Int32]
  filtration : Double
}

///|
/// Construct a simplex with filtration value. / 构造带过滤值的单纯形。
pub fn SimplexWithFiltration::new(
  vertices : Array[Int32],
  filtration : Double,
) -> SimplexWithFiltration {
  { vertices, filtration, }
}

///|
/// Persistence diagram: collection of barcodes. / 持久同调图：条形码集合。
pub struct PersistenceDiagram {
  barcodes : Array[Barcode]
}

///|
/// Construct an empty persistence diagram. / 构造空的持久同调图。
pub fn PersistenceDiagram::new() -> PersistenceDiagram {
  { barcodes: [], }
}

///|
/// Get the number of barcodes. / 获取条形码数量。
pub fn PersistenceDiagram::barcode_count(pd : PersistenceDiagram) -> Int32 {
  pd.barcodes.length()
}

///|
/// Get the dimension of a simplex (number of vertices - 1). / 获取单纯形维度（顶点数 - 1）。
fn simplex_dim(s : SimplexWithFiltration) -> Int32 {
  s.vertices.length() - 1
}

///|
/// Check if simplex a is a face of simplex b (subset of vertices). / 检查单纯形 a 是否为单纯形 b 的面（顶点子集）。
fn is_face(a : Array[Int32], b : Array[Int32]) -> Bool {
  if a.length() != b.length() - 1 {
    return false
  }
  for v in a {
    let mut found = false
    for w in b {
      if v == w {
        found = true
        break
      }
    }
    if !found {
      return false
    }
  }
  true
}

///|
/// Compute persistence pairs via boundary matrix reduction (Z/2Z). / 通过边界矩阵约化计算持久对（Z/2Z）。
pub fn persistence_pairs(
  simplices : Array[SimplexWithFiltration],
) -> Array[(Int32, Int32)] {
  let n = simplices.length()
  if n == 0 {
    return []
  }
  let order = sort_by_filtration(simplices)
  let boundary : Array[Array[Int32]] = Array::make(n, [])
  for j in 0..<n {
    let col : Array[Int32] = []
    for i in 0..<n {
      if is_face(simplices[order[i]].vertices, simplices[order[j]].vertices) {
        col.push(i)
      }
    }
    boundary[j] = col
  }
  let lowest : Array[Int32] = Array::make(n, -1)
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
  let pairs : Array[(Int32, Int32)] = []
  let reduced : Array[Array[Int32]] = []
  for i in 0..<n {
    reduced.push(boundary[i].copy())
  }
  let low_map : Array[Int32] = Array::make(n, -1)
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
      let new_col : Array[Int32] = []
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

///|
fn sort_by_filtration(simplices : Array[SimplexWithFiltration]) -> Array[Int32] {
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

///|
/// Compute barcodes from a filtration. / 由过滤计算条形码。
pub fn compute_barcode(
  simplices : Array[SimplexWithFiltration],
) -> Array[Barcode] {
  let n = simplices.length()
  if n == 0 {
    return []
  }
  let order = sort_by_filtration(simplices)
  let pairs = persistence_pairs(simplices)
  let paired_death : Array[Int32] = Array::make(n, -1)
  let paired_birth : Array[Int32] = Array::make(n, -1)
  for p in pairs {
    paired_death[p.0] = p.1
    paired_birth[p.1] = p.0
  }
  let barcodes : Array[Barcode] = []
  for i in 0..<n {
    if paired_death[i] == -1 && paired_birth[i] == -1 {
      let idx = order[i]
      let dim = simplex_dim(simplices[idx])
      barcodes.push({
        birth: simplices[idx].filtration,
        death: 999999999.0,
        dimension: dim,
      })
    }
    if paired_death[i] != -1 {
      let birth_idx = order[i]
      let death_idx = order[paired_death[i]]
      let dim = simplex_dim(simplices[birth_idx])
      barcodes.push({
        birth: simplices[birth_idx].filtration,
        death: simplices[death_idx].filtration,
        dimension: dim,
      })
    }
  }
  barcodes
}

///|
/// Compute persistent homology from a filtration. / 由过滤计算持久同调。
pub fn persistent_homology(
  simplices : Array[SimplexWithFiltration],
) -> PersistenceDiagram {
  { barcodes: compute_barcode(simplices), }
}

///|
/// Compute Betti numbers from a barcode at a given threshold. / 由条形码在给定阈值处计算 Betti 数。
pub fn betti_from_barcode(
  barcodes : Array[Barcode],
  threshold : Double,
) -> Array[Int32] {
  let betti = Array::make(3, 0)
  for b in barcodes {
    if b.birth <= threshold + 0.0000000001 &&
      (b.death > threshold || b.is_infinite()) {
      if b.dimension >= 0 && b.dimension < 3 {
        betti[b.dimension] += 1
      }
    }
  }
  betti
}
