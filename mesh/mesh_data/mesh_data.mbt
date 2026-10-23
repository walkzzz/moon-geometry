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

///|
/// Get the number of edges (each face has 3 edges, shared edges counted once). / 获取边数（每个面 3 条边，共享边只计一次）。
pub impl @core.EdgeCountable for Mesh with fn edge_count(self) {
  let edge_set : Array[(Int32, Int32)] = []
  for f in self.faces {
    add_edge_unique(edge_set, f.v0, f.v1)
    add_edge_unique(edge_set, f.v1, f.v2)
    add_edge_unique(edge_set, f.v2, f.v0)
  }
  edge_set.length()
}

///|
fn add_edge_unique(edges : Array[(Int32, Int32)], a : Int32, b : Int32) -> Unit {
  let (lo, hi) = if a < b { (a, b) } else { (b, a) }
  for e in edges {
    if e.0 == lo && e.1 == hi {
      return
    }
  }
  edges.push((lo, hi))
}

///|
/// Get a vertex by index. / 按索引获取顶点。
pub fn Mesh::get_vertex(m : Mesh, i : Int32) -> @core.Point3D {
  m.vertices[i]
}

///|
/// Get a face by index. / 按索引获取面。
pub fn Mesh::get_face(m : Mesh, i : Int32) -> MeshFace {
  m.faces[i]
}

///|
/// Compute the bounding box of the mesh. / 计算网格的包围盒。
pub fn Mesh::bounding_box(m : Mesh) -> (@core.Point3D, @core.Point3D) {
  if m.vertices.length() == 0 {
    return (
      @core.Point3D::new(0.0, 0.0, 0.0),
      @core.Point3D::new(0.0, 0.0, 0.0),
    )
  }
  let mut min_x = m.vertices[0].x
  let mut min_y = m.vertices[0].y
  let mut min_z = m.vertices[0].z
  let mut max_x = m.vertices[0].x
  let mut max_y = m.vertices[0].y
  let mut max_z = m.vertices[0].z
  for v in m.vertices {
    min_x = min_x.min(v.x)
    min_y = min_y.min(v.y)
    min_z = min_z.min(v.z)
    max_x = max_x.max(v.x)
    max_y = max_y.max(v.y)
    max_z = max_z.max(v.z)
  }
  (
    @core.Point3D::new(min_x, min_y, min_z),
    @core.Point3D::new(max_x, max_y, max_z),
  )
}

///|
/// Build a mesh from a tetrahedron. / 由四面体构建网格。
pub fn Mesh::tetrahedron(
  a : @core.Point3D,
  b : @core.Point3D,
  c : @core.Point3D,
  d : @core.Point3D,
) -> Mesh {
  let m = Mesh::new()
  let i0 = m.add_vertex(a)
  let i1 = m.add_vertex(b)
  let i2 = m.add_vertex(c)
  let i3 = m.add_vertex(d)
  m.add_face(i0, i1, i2)
  m.add_face(i0, i1, i3)
  m.add_face(i0, i2, i3)
  m.add_face(i1, i2, i3)
  m
}
