///|
/// Create an empty OBJ mesh. / 创建空 OBJ 网格。
pub fn ObjMesh::new() -> ObjMesh {
  { vertices: [], texcoords: [], normals: [], faces: [], }
}

///|
/// Number of vertices. / 顶点数。
pub impl @core.VertexCountable for ObjMesh with fn vertex_count(self) {
  self.vertices.length()
}

///|
/// Number of faces. / 面数。
pub impl @core.FaceCountable for ObjMesh with fn face_count(self) {
  self.faces.length()
}
