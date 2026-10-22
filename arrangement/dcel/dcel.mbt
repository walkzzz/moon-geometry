///|
/// Half-edge in a Doubly Connected Edge List (DCEL). / 双向连接边表（DCEL）中的半边。
pub struct HalfEdge {
  origin : Int
  twin : Int
  mut next : Int
  mut prev : Int
  mut face : Int
}

///|
/// Face record in a DCEL. / DCEL 中的面记录。
pub struct Face {
  outer_component : Int
  inner_components : Array[Int]
}

///|
/// Doubly Connected Edge List (DCEL) structure for planar subdivisions. / 用于平面细分的双向连接边表（DCEL）结构。
pub struct DCEL {
  vertices : Array[@core.Point2D]
  half_edges : Array[HalfEdge]
  faces : Array[Face]
}

///|
pub extend DCEL with @core.VertexCountable::{vertex_count}

///|
pub extend DCEL with @core.FaceCountable::{face_count}

///|
pub extend DCEL with @core.EdgeCountable::{edge_count}

///|
/// Create an empty DCEL. / 创建空的 DCEL。
pub fn DCEL::new() -> DCEL {
  { vertices: [], half_edges: [], faces: [] }
}

///|
/// Add a vertex to the DCEL, returns its index. / 向 DCEL 添加顶点，返回其索引。
pub fn DCEL::add_vertex(dcel : DCEL, p : @core.Point2D) -> Int {
  let idx = dcel.vertices.length()
  dcel.vertices.push(p)
  idx
}

///|
/// Add a pair of twin half-edges between two vertices. / 在两个顶点之间添加一对孪生半边。
pub fn DCEL::add_edge(dcel : DCEL, from : Int, to : Int) -> Int {
  let n = dcel.half_edges.length()
  let he1 : HalfEdge = {
    origin: from,
    twin: n + 1,
    next: -1,
    prev: -1,
    face: -1,
  }
  let he2 : HalfEdge = {
    origin: to,
    twin: n,
    next: -1,
    prev: -1,
    face: -1,
  }
  dcel.half_edges.push(he1)
  dcel.half_edges.push(he2)
  n
}

///|
/// Add a face to the DCEL, returns its index. / 向 DCEL 添加面，返回其索引。
pub fn DCEL::add_face(dcel : DCEL, outer : Int) -> Int {
  let idx = dcel.faces.length()
  dcel.faces.push({ outer_component: outer, inner_components: [] })
  idx
}

///|
/// Set the next/prev links for a half-edge. / 设置半边的 next/prev 链接。
pub fn DCEL::set_next(dcel : DCEL, he : Int, next : Int) -> Unit {
  dcel.half_edges[he].next = next
  dcel.half_edges[next].prev = he
}

///|
/// Set the face of a half-edge. / 设置半边所属的面。
pub fn DCEL::set_face(dcel : DCEL, he : Int, face : Int) -> Unit {
  dcel.half_edges[he].face = face
}

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

///|
/// Traverse the boundary of a face starting from a half-edge. / 从半边开始遍历面的边界。
pub fn DCEL::trace_face(dcel : DCEL, start_he : Int) -> Array[Int] {
  let result : Array[Int] = []
  let mut current = start_he
  let mut first = true
  while first || current != start_he {
    result.push(current)
    first = false
    if dcel.half_edges[current].next == -1 {
      break
    }
    current = dcel.half_edges[current].next
  }
  result
}

///|
/// Build a DCEL from a simple polygon. / 由简单多边形构建 DCEL。
pub fn DCEL::from_polygon(dcel : DCEL, poly : @core.Polygon) -> DCEL {
  let n = poly.size()
  if n < 3 {
    return dcel
  }
  let vertex_indices : Array[Int] = []
  for i in 0..<n {
    let idx = dcel.add_vertex(poly.get(i))
    vertex_indices.push(idx)
  }
  let edge_indices : Array[Int] = []
  for i in 0..<n {
    let next_v = (i + 1) % n
    let ei = dcel.add_edge(vertex_indices[i], vertex_indices[next_v])
    edge_indices.push(ei)
  }
  let face_idx = dcel.add_face(edge_indices[0])
  for i in 0..<n {
    let next_i = (i + 1) % n
    dcel.set_next(edge_indices[i], edge_indices[next_i])
    dcel.set_face(edge_indices[i], face_idx)
  }
  dcel
}