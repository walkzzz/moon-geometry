///|
/// Voronoi diagram from Delaunay triangulation (duality).
/// 从 Delaunay 三角剖分构造 Voronoi 图（对偶）。
/// Returns (vertices, edges) where vertices are circumcenters of Delaunay
/// 返回 (顶点, 边)，顶点为 Delaunay
/// triangles and edges connect circumcenters of adjacent triangles.
/// 三角形的外心，边连接相邻三角形的外心。
pub fn voronoi_diagram(
  points : Array[@core.Point2D],
) -> (Array[@core.Point2D], Array[(Int32, Int32)]) {
  let tris = delaunay_triangulation(points)
  let vertices : Array[@core.Point2D] = []
  for t in tris {
    let tri = @core.Triangle::new(points[t.a], points[t.b], points[t.c])
    vertices.push(tri.circumcenter())
  }
  // Edges: for each pair of triangles sharing an edge, connect their circumcenters
  let edges : Array[(Int32, Int32)] = []
  let m = tris.length()
  for i in 0..<m {
    let ei = tri_edges(tris[i])
    for j in (i + 1)..<m {
      let ej = tri_edges(tris[j])
      // Check if they share an edge
      let mut shared = 0
      for a in ei {
        for b in ej {
          if edge_eq(a, b) {
            shared += 1
          }
        }
      }
      if shared >= 1 {
        edges.push((i, j))
      }
    }
  }
  (vertices, edges)
}
