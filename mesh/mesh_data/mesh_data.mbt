///|
/// Triangle face in a mesh (vertex indices). / 网格中的三角面（顶点索引）。
pub struct MeshFace {
  v0 : Int32
  v1 : Int32
  v2 : Int32
}

///|
/// 3D triangle mesh data structure. / 三维三角网格数据结构。
pub struct Mesh {
  vertices : Array[@core.Point3D]
  faces : Array[MeshFace]
}

///|
pub extend Mesh with @core.VertexCountable::{vertex_count}

///|
pub extend Mesh with @core.FaceCountable::{face_count}

///|
pub extend Mesh with @core.EdgeCountable::{edge_count}

///|
/// Create an empty mesh. / 创建空网格。
pub fn Mesh::new() -> Mesh {
  { vertices: [], faces: [], }
}

///|
/// Add a vertex to the mesh, returns its index. / 向网格添加顶点，返回其索引。
pub fn Mesh::add_vertex(m : Mesh, p : @core.Point3D) -> Int32 {
  let idx = m.vertices.length()
  m.vertices.push(p)
  idx
}
