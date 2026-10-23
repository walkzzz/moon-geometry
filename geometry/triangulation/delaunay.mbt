///|
/// A triangle as three vertex indices into a point array.
/// 表示为点数组中三个顶点索引的三角形。
pub struct TriangleIdx {
  a : Int32
  b : Int32
  c : Int32
} derive(Debug)

///|
/// Normalize an edge so the smaller index comes first.
/// 规范化边，使较小索引在前。
fn norm_edge(a : Int32, b : Int32) -> (Int32, Int32) {
  if a < b {
    (a, b)
  } else {
    (b, a)
  }
}

///|
/// Edges of a triangle as normalized index pairs.
/// 三角形的边，以规范化索引对表示。
fn tri_edges(t : TriangleIdx) -> Array[(Int32, Int32)] {
  [norm_edge(t.a, t.b), norm_edge(t.b, t.c), norm_edge(t.c, t.a)]
}

///|
/// Whether two index pairs are equal.
/// 两个索引对是否相等。
fn edge_eq(e1 : (Int32, Int32), e2 : (Int32, Int32)) -> Bool {
  let (a1, b1) = e1
  let (a2, b2) = e2
  a1 == a2 && b1 == b2
}
