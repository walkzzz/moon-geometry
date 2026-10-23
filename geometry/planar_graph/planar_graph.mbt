///|
/// Edge in a planar graph. / 平面图中的边。
pub struct PlanarEdge {
  from : Int32
  to : Int32
}

///|
/// Planar graph with vertices and edges. / 带顶点和边的平面图。
pub struct PlanarGraph {
  vertices : Array[@core.Point2D]
  edges : Array[PlanarEdge]
  adj : Array[Array[Int32]]
}

///|
pub extend PlanarGraph with @core.VertexCountable::{vertex_count}

///|
pub extend PlanarGraph with @core.FaceCountable::{face_count}

///|
pub extend PlanarGraph with @core.EdgeCountable::{edge_count}

///|
/// Create an empty planar graph. / 创建空平面图。
pub fn PlanarGraph::new() -> PlanarGraph {
  { vertices: [], edges: [], adj: [], }
}

///|
/// Add a vertex to the planar graph, returns its index. / 向平面图添加顶点，返回其索引。
pub fn PlanarGraph::add_vertex(graph : PlanarGraph, p : @core.Point2D) -> Int32 {
  let idx = graph.vertices.length()
  graph.vertices.push(p)
  graph.adj.push([])
  idx
}
