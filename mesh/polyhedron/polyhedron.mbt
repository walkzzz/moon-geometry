///|
/// Polyhedron represented as vertices and faces (polygon face = vertex indices). / 多面体（顶点 + 面，面为顶点索引数组）。
pub struct Polyhedron {
  vertices : Array[@core.Point3D]
  faces : Array[Array[Int]]
}


///|
pub extend Polyhedron with @core.Measurable3D::{volume, surface_area}


///|
pub extend Polyhedron with @core.VertexCountable::{vertex_count}


///|
pub extend Polyhedron with @core.FaceCountable::{face_count}


///|
pub extend Polyhedron with @core.EdgeCountable::{edge_count}


///|
/// Construct an empty polyhedron. / 构造空多面体。
pub fn Polyhedron::new() -> Polyhedron {
  { vertices: [], faces: [] }
}


///|
/// Add a vertex, returns index. / 添加顶点，返回索引。
pub fn Polyhedron::add_vertex(p : Polyhedron, v : @core.Point3D) -> Int {
  let idx = p.vertices.length()
  p.vertices.push(v)
  idx
}
