///|
/// Trait for structures with a countable number of vertices.
/// 有可数顶点的结构 trait。
pub(open) trait VertexCountable {
  vertex_count(self : Self) -> Int
}


///|
/// Trait for structures with a countable number of faces.
/// 有可数面的结构 trait。
pub(open) trait FaceCountable {
  face_count(self : Self) -> Int
}

///|
/// Trait for structures with a countable number of edges.
/// 有可数边的结构 trait。
pub(open) trait EdgeCountable {
  edge_count(self : Self) -> Int
}