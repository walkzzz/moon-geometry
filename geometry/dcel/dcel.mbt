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
