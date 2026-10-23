///|
/// Add a face (list of vertex indices). / 添加面（顶点索引列表）。
pub fn Polyhedron::add_face(p : Polyhedron, indices : Array[Int32]) -> Unit {
  p.faces.push(indices)
}

///|
/// Number of vertices. / 顶点数。
pub impl @core.VertexCountable for Polyhedron with fn vertex_count(self) {
  self.vertices.length()
}

///|
/// Number of faces. / 面数。
pub impl @core.FaceCountable for Polyhedron with fn face_count(self) {
  self.faces.length()
}
