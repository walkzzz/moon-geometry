///|
/// Half-edge in a Doubly Connected Edge List (DCEL). / 双向连接边表（DCEL）中的半边。
pub struct HalfEdge {
  origin : Int32
  twin : Int32
  mut next : Int32
  mut prev : Int32
  mut face : Int32
}

///|
/// Face record in a DCEL. / DCEL 中的面记录。
pub struct Face {
  outer_component : Int32
  inner_components : Array[Int32]
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
