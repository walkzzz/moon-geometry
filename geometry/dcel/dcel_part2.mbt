///|
/// Create an empty DCEL. / 创建空的 DCEL。
pub fn DCEL::new() -> DCEL {
  { vertices: [], half_edges: [], faces: [], }
}

///|
/// Add a vertex to the DCEL, returns its index. / 向 DCEL 添加顶点，返回其索引。
pub fn DCEL::add_vertex(dcel : DCEL, p : @core.Point2D) -> Int32 {
  let idx = dcel.vertices.length()
  dcel.vertices.push(p)
  idx
}

///|
/// Add a pair of twin half-edges between two vertices. / 在两个顶点之间添加一对孪生半边。
pub fn DCEL::add_edge(dcel : DCEL, from : Int32, to : Int32) -> Int32 {
  let n = dcel.half_edges.length()
  let he1 : HalfEdge = {
    origin: from,
    twin: n + 1,
    next: -1,
    prev: -1,
    face: -1,
  }
  let he2 : HalfEdge = { origin: to, twin: n, next: -1, prev: -1, face: -1, }
  dcel.half_edges.push(he1)
  dcel.half_edges.push(he2)
  n
}

///|
/// Add a face to the DCEL, returns its index. / 向 DCEL 添加面，返回其索引。
pub fn DCEL::add_face(dcel : DCEL, outer : Int32) -> Int32 {
  let idx = dcel.faces.length()
  dcel.faces.push({ outer_component: outer, inner_components: [], })
  idx
}

///|
/// Set the next/prev links for a half-edge. / 设置半边的 next/prev 链接。
pub fn DCEL::set_next(dcel : DCEL, he : Int32, next : Int32) -> Unit {
  dcel.half_edges[he].next = next
  dcel.half_edges[next].prev = he
}

///|
/// Set the face of a half-edge. / 设置半边所属的面。
pub fn DCEL::set_face(dcel : DCEL, he : Int32, face : Int32) -> Unit {
  dcel.half_edges[he].face = face
}
