///|
/// # Persistence Diagram
/// # 持久性图
///
/// Persistence diagram representation for topological features.
/// 拓扑特征的持久性图表示。

///|
pub struct PersistencePoint {
  birth : Double
  death : Double
}

///|
pub fn PersistencePoint::new(birth : Double, death : Double) -> PersistencePoint {
  { birth, death, }
}

///|
pub fn persistence(p : PersistencePoint) -> Double {
  p.death - p.birth
}

///|
pub fn is_essential(p : PersistencePoint) -> Bool {
  p.death > 99999999.0
}

///|
pub fn diagram_dimension(diagram : Array[PersistencePoint]) -> Int {
  diagram.length()
}

///|
pub fn max_persistence(diagram : Array[PersistencePoint]) -> Double {
  let mut max_p = 0.0
  for i in 0..<diagram.length() {
    let p = persistence(diagram[i])
    if p > max_p { max_p = p }
  }
  max_p
}
