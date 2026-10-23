///|
/// Compute 3D Voronoi diagram as the dual of 3D Delaunay triangulation. / 计算三维 Voronoi 图，作为三维 Delaunay 三角剖分的对偶。
pub fn voronoi_3d(sites : Array[@core.Point3D]) -> Voronoi3D {
  let n = sites.length()
  if n == 0 {
    return { sites: [], cells: [], vertices: [] }
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
    cells.push({ site_idx: i, vertices: cell_verts })
  }
  { sites: sites.copy(), cells, vertices: voronoi_vertices }
}
