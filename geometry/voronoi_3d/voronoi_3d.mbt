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

///|
/// Compute 3D Voronoi diagram as the dual of 3D Delaunay triangulation. / 计算三维 Voronoi 图，作为三维 Delaunay 三角剖分的对偶。
pub fn voronoi_3d(sites : Array[@core.Point3D]) -> Voronoi3D {
  let n = sites.length()
  if n == 0 {
    return { sites: [], cells: [], vertices: [], }
  }
  let del = @delaunay_3d.delaunay_3d(sites)
  let voronoi_vertices : Array[@core.Point3D] = []
  for t in del.tetrahedra {
    let a = sites[t.v0]
    let b = sites[t.v1]
    let c = sites[t.v2]
    let d = sites[t.v3]
    let center = @delaunay_3d.circumsphere_center(a, b, c, d)
    voronoi_vertices.push(center)
  }
  let cells : Array[VoronoiCell3D] = []
  for i in 0..<n {
    let cell_verts : Array[@core.Point3D] = []
    for ti in 0..<del.tetrahedra.length() {
      let t = del.tetrahedra[ti]
      if t.v0 == i || t.v1 == i || t.v2 == i || t.v3 == i {
        cell_verts.push(voronoi_vertices[ti])
      }
    }
    cells.push({ site_idx: i, vertices: cell_verts, })
  }
  { sites: sites.copy(), cells, vertices: voronoi_vertices, }
}

///|
/// Get a specific Voronoi cell by site index. / 按站点索引获取 Voronoi 单元。
pub fn voronoi_cell_3d(v : Voronoi3D, site_idx : Int32) -> VoronoiCell3D {
  for c in v.cells {
    if c.site_idx == site_idx {
      return c
    }
  }
  { site_idx, vertices: [], }
}

///|
/// Count Voronoi cells (equals number of sites). / 计算 Voronoi 单元数（等于站点数）。
pub fn voronoi_cell_count(sites : Array[@core.Point3D]) -> Int32 {
  sites.length()
}

///|
/// Count Voronoi vertices from Delaunay tetrahedra. / 由 Delaunay 四面体计算 Voronoi 顶点数。
pub fn voronoi_vertex_count(sites : Array[@core.Point3D]) -> Int32 {
  let del = @delaunay_3d.delaunay_3d(sites)
  del.tetrahedron_count()
}

///|
/// Compute the dual Delaunay triangulation from a Voronoi diagram. / 由 Voronoi 图计算对偶 Delaunay 三角剖分。
pub fn dual_delaunay(sites : Array[@core.Point3D]) -> @delaunay_3d.Delaunay3D {
  @delaunay_3d.delaunay_3d(sites)
}
