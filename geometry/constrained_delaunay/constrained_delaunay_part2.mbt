///|
/// Check if an edge is a constrained edge. / 检查边是否为约束边。
pub fn is_constrained_edge(
  cd : ConstrainedDelaunay,
  a : Int,
  b : Int,
) -> Bool {
  let (lo, hi) = if a < b {
    (a, b)
  } else {
    (b, a)
  }
  for c in cd.constraints {
    let (clo, chi) = if c.0 < c.1 {
      (c.0, c.1)
    } else {
      (c.1, c.0)
    }
    if clo == lo && chi == hi {
      return true
    }
  }
  false
}
