///|
/// Create an empty OBJ mesh. / 创建空 OBJ 网格。
pub fn ObjMesh::new() -> ObjMesh {
  { vertices: [], texcoords: [], normals: [], faces: [] }
}


///|
/// Number of vertices. / 顶点数。
pub impl @core.VertexCountable for ObjMesh with vertex_count(self) {
  self.vertices.length()
}


///|
/// Number of faces. / 面数。
pub impl @core.FaceCountable for ObjMesh with face_count(self) {
  self.faces.length()
}
