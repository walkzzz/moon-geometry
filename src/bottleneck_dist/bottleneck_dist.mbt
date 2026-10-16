///|
/// # Bottleneck Distance
/// # 瓶颈距离
///
/// Bottleneck distance between persistence diagrams.
/// 持久性图之间的瓶颈距离。

///|
pub fn bottleneck_distance(d1 : Array[@persistence_diagram.PersistencePoint], d2 : Array[@persistence_diagram.PersistencePoint]) -> Double {
  let n1 = d1.length()
  let n2 = d2.length()
  if n1 == 0 && n2 == 0 { return 0.0 }
  let mut max_dist = 0.0
  for i in 0..<n1 {
    let mut min_d = 999999999.0
    for j in 0..<n2 {
      let db = (d1[i].birth - d2[j].birth).abs()
      let dd = (d1[i].death - d2[j].death).abs()
      let d = if db > dd { db } else { dd }
      if d < min_d { min_d = d }
    }
    if min_d > max_dist { max_dist = min_d }
  }
  max_dist
}

///|
pub fn bottleneck_upper_bound(d1 : Array[@persistence_diagram.PersistencePoint], d2 : Array[@persistence_diagram.PersistencePoint]) -> Double {
  let m1 = @persistence_diagram.max_persistence(d1)
  let m2 = @persistence_diagram.max_persistence(d2)
  (m1 - m2).abs() + 1.0
}

///|
pub fn bottleneck_lower_bound(d1 : Array[@persistence_diagram.PersistencePoint], d2 : Array[@persistence_diagram.PersistencePoint]) -> Double {
  let m1 = @persistence_diagram.max_persistence(d1)
  let m2 = @persistence_diagram.max_persistence(d2)
  (m1 - m2).abs() / 2.0
}
