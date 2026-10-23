///|
/// Get the number of vertices. / 获取顶点数量。
pub impl @core.VertexCountable for DCEL with vertex_count(self) {
  self.vertices.length()
}


///|
/// Get the number of half-edges. / 获取半边数量。
pub impl @core.EdgeCountable for DCEL with edge_count(self) {
  self.half_edges.length()
}


///|
/// Get the number of faces. / 获取面数量。
pub impl @core.FaceCountable for DCEL with face_count(self) {
  self.faces.length()
}
