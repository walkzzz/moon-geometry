///|
/// Get a specific Voronoi cell by site index. / 按站点索引获取 Voronoi 单元。
pub fn voronoi_cell_3d(v : Voronoi3D, site_idx : Int) -> VoronoiCell3D {
  for c in v.cells {
    if c.site_idx == site_idx {
      return c
    }
  }
  { site_idx, vertices: [] }
}


///|
/// Count Voronoi cells (equals number of sites). / 计算 Voronoi 单元数（等于站点数）。
pub fn voronoi_cell_count(sites : Array[@core.Point3D]) -> Int {
  sites.length()
}


///|
/// Count Voronoi vertices from Delaunay tetrahedra. / 由 Delaunay 四面体计算 Voronoi 顶点数。
pub fn voronoi_vertex_count(sites : Array[@core.Point3D]) -> Int {
  let del = @delaunay_3d.delaunay_3d(sites)
  del.tetrahedron_count()
}


///|
/// Compute the dual Delaunay triangulation from a Voronoi diagram. / 由 Voronoi 图计算对偶 Delaunay 三角剖分。
pub fn dual_delaunay(sites : Array[@core.Point3D]) -> @delaunay_3d.Delaunay3D {
  @delaunay_3d.delaunay_3d(sites)
}