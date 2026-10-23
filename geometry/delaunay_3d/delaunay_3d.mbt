///|
/// Tetrahedron in a 3D Delaunay triangulation (vertex indices). / 三维 Delaunay 三角剖分中的四面体（顶点索引）。
pub struct Tetrahedron {
  v0 : Int32
  v1 : Int32
  v2 : Int32
  v3 : Int32
}

///|
/// 3D Delaunay triangulation result. / 三维 Delaunay 三角剖分结果。
pub struct Delaunay3D {
  vertices : Array[@core.Point3D]
  tetrahedra : Array[Tetrahedron]
}

///|
pub extend Delaunay3D with @core.VertexCountable::{vertex_count}

///|
/// Construct an empty 3D Delaunay triangulation. / 构造空的三维 Delaunay 三角剖分。
pub fn Delaunay3D::new() -> Delaunay3D {
  { vertices: [], tetrahedra: [], }
}

///|
/// Get the number of tetrahedra. / 获取四面体数量。
pub fn Delaunay3D::tetrahedron_count(d : Delaunay3D) -> Int32 {
  d.tetrahedra.length()
}

///|
/// Get the number of vertices. / 获取顶点数量。
pub impl @core.VertexCountable for Delaunay3D with fn vertex_count(self) {
  self.vertices.length()
}
