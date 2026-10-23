///|
/// A 3D Voronoi cell: the region of space closest to a given site. / 三维 Voronoi 单元：空间中距离某站点最近的区域。
pub struct VoronoiCell3D {
  site_idx : Int32
  vertices : Array[@core.Point3D]
}

///|
/// 3D Voronoi diagram, dual of 3D Delaunay triangulation. / 三维 Voronoi 图，三维 Delaunay 三角剖分的对偶。
pub struct Voronoi3D {
  sites : Array[@core.Point3D]
  cells : Array[VoronoiCell3D]
  vertices : Array[@core.Point3D]
}

///|
pub extend Voronoi3D with @core.VertexCountable::{vertex_count}

///|
/// Construct an empty 3D Voronoi diagram. / 构造空的三维 Voronoi 图。
pub fn Voronoi3D::new() -> Voronoi3D {
  { sites: [], cells: [], vertices: [], }
}

///|
/// Get the number of Voronoi cells. / 获取 Voronoi 单元数量。
pub fn Voronoi3D::cell_count(v : Voronoi3D) -> Int32 {
  v.cells.length()
}

///|
/// Get the number of Voronoi vertices. / 获取 Voronoi 顶点数量。
pub impl @core.VertexCountable for Voronoi3D with fn vertex_count(self) {
  self.vertices.length()
}
