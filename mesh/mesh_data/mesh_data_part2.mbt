///|
/// Add a triangular face to the mesh. / 向网格添加三角面。
pub fn Mesh::add_face(m : Mesh, v0 : Int32, v1 : Int32, v2 : Int32) -> Unit {
  m.faces.push({ v0, v1, v2, })
}

///|
/// Get the number of vertices. / 获取顶点数。
pub impl @core.VertexCountable for Mesh with fn vertex_count(self) {
  self.vertices.length()
}

///|
/// Get the number of faces. / 获取面数。
pub impl @core.FaceCountable for Mesh with fn face_count(self) {
  self.faces.length()
}
