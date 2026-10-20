///|
/// # Wasserstein Distance
/// # Wasserstein 距离
///
/// p-Wasserstein distance between persistence diagrams.
/// 持久性图之间的 p-Wasserstein 距离。

///|
pub fn wasserstein_1_distance(d1 : Array[@persistence_diagram.PersistencePoint], d2 : Array[@persistence_diagram.PersistencePoint]) -> Double {
  let n = if d1.length() < d2.length() { d1.length() } else { d2.length() }
  if n == 0 { return 0.0 }
  let mut sum = 0.0
  for i in 0..<n {
    let db = (d1[i].birth - d2[i].birth).abs()
    let dd = (d1[i].death - d2[i].death).abs()
    sum += db + dd
  }
  sum
}

///|
pub fn wasserstein_inf_distance(d1 : Array[@persistence_diagram.PersistencePoint], d2 : Array[@persistence_diagram.PersistencePoint]) -> Double {
  let n = if d1.length() < d2.length() { d1.length() } else { d2.length() }
  if n == 0 { return 0.0 }
  let mut max_d = 0.0
  for i in 0..<n {
    let db = (d1[i].birth - d2[i].birth).abs()
    let dd = (d1[i].death - d2[i].death).abs()
    let d = if db > dd { db } else { dd }
    if d > max_d { max_d = d }
  }
  max_d
}

///|
pub fn wasserstein_p_distance(d1 : Array[@persistence_diagram.PersistencePoint], d2 : Array[@persistence_diagram.PersistencePoint], p : Double) -> Double {
  let n = if d1.length() < d2.length() { d1.length() } else { d2.length() }
  if n == 0 { return 0.0 }
  let mut sum = 0.0
  for i in 0..<n {
    let db = (d1[i].birth - d2[i].birth).abs()
    let dd = (d1[i].death - d2[i].death).abs()
    let dist = (db * db + dd * dd).sqrt()
    sum += pow_double(dist, p)
  }
  pow_double(sum, 1.0 / p)
}

fn pow_double(base : Double, exp : Double) -> Double {
  if base < 0.000000000001 { return 0.0 }
  @math.exp(exp * @math.ln(base))
}
