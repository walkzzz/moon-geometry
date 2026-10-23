///|
/// Build a DCEL from a simple polygon. / 由简单多边形构建 DCEL。
pub fn DCEL::from_polygon(dcel : DCEL, poly : @core.Polygon) -> DCEL {
  let n = poly.size()
  if n < 3 {
    return dcel
  }
  let vertex_indices : Array[Int32] = []
  for i in 0..<n {
    let idx = dcel.add_vertex(poly.get(i))
    vertex_indices.push(idx)
  }
  let edge_indices : Array[Int32] = []
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
