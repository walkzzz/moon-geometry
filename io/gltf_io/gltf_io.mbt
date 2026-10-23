///|
/// glTF mesh: vertices + triangle indices.
/// glTF 网格：顶点 + 三角形索引。
pub struct GltfMesh {
  vertices : Array[@core.Point3D]
  indices : Array[Int]
}


///|
pub extend GltfMesh with @core.VertexCountable::{vertex_count}


///|
/// Create an empty glTF mesh. / 创建空 glTF 网格。
pub fn GltfMesh::new() -> GltfMesh {
  { vertices: [], indices: [] }
}


///|
/// Number of vertices. / 顶点数。
pub impl @core.VertexCountable for GltfMesh with vertex_count(self) {
  self.vertices.length()
}


///|
/// Number of indices. / 索引数。
pub fn GltfMesh::index_count(m : GltfMesh) -> Int {
  m.indices.length()
}
