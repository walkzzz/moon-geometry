///|
/// # Persistence Landscape
/// # 持久性景观
///
/// Persistence landscape: vectorized representation of persistence diagrams.
/// 持久性景观：持久性图的向量化表示。

///|
pub fn landscape_k(point : @persistence_diagram.PersistencePoint, k : Int, t : Double) -> Double {
  let birth = point.birth
  let death = point.death
  let mid = (birth + death) / 2.0
  if k != 1 { return 0.0 }
  if t < birth || t > death { return 0.0 }
  if t <= mid { t - birth } else { death - t }
}

///|
pub fn landscape_sup(point : @persistence_diagram.PersistencePoint) -> Double {
  let pers = @persistence_diagram.persistence(point)
  pers / 2.0
}

///|
pub fn landscape_norm_1(diagram : Array[@persistence_diagram.PersistencePoint]) -> Double {
  let mut sum = 0.0
  for i in 0..<diagram.length() {
    let p = @persistence_diagram.persistence(diagram[i])
    sum += p * p / 4.0
  }
  sum
}

///|
pub fn landscape_norm_inf(diagram : Array[@persistence_diagram.PersistencePoint]) -> Double {
  let mut max_val = 0.0
  for i in 0..<diagram.length() {
    let val = landscape_sup(diagram[i])
    if val > max_val { max_val = val }
  }
  max_val
}
