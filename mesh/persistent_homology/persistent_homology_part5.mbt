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
  let paired_death : Array[Int] = Array::make(n, -1)
  let paired_birth : Array[Int] = Array::make(n, -1)
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
