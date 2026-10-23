///|
/// Delaunay triangulation via Bowyer-Watson incremental insertion. O(n^2) expected.
/// Bowyer-Watson 增量插入法 Delaunay 三角剖分。期望 O(n^2)。
/// Returns an array of triangles as vertex index triples (CCW).
/// 返回逆时针顶点索引三元组数组。
pub fn delaunay_triangulation(
  points : Array[@core.Point2D],
) -> Array[TriangleIdx] {
  let n = points.length()
  if n < 3 {
    return []
  }
  // Compute bounding box
  let mut minx = points[0].x
  let mut maxx = points[0].x
  let mut miny = points[0].y
  let mut maxy = points[0].y
  for i in 1..<n {
    if points[i].x < minx {
      minx = points[i].x
    }
    if points[i].x > maxx {
      maxx = points[i].x
    }
    if points[i].y < miny {
      miny = points[i].y
    }
    if points[i].y > maxy {
      maxy = points[i].y
    }
  }
  let dx = maxx - minx
  let dy = maxy - miny
  let delta = if dx > dy { dx } else { dy }
  let delta_max = if delta > 0.0 { delta } else { 1.0 }
  let midx = (minx + maxx) / 2.0
  let midy = (miny + maxy) / 2.0
  // Super-triangle vertices (indices n, n+1, n+2)
  let all_pts = points.copy()
  all_pts.push(@core.Point2D::new(midx - 20.0 * delta_max, midy - delta_max))
  all_pts.push(@core.Point2D::new(midx, midy + 20.0 * delta_max))
  all_pts.push(@core.Point2D::new(midx + 20.0 * delta_max, midy - delta_max))
  let sa = n
  let sb = n + 1
  let sc = n + 2
  let tris : Array[TriangleIdx] = [make_tri_ccw(sa, sb, sc, all_pts)]
  // Incrementally insert each point
  for i in 0..<n {
    let p = all_pts[i]
    // Find bad triangles whose circumcircle contains p
    let bad : Array[TriangleIdx] = []
    let good : Array[TriangleIdx] = []
    for t in tris {
      if in_circumcircle(all_pts[t.a], all_pts[t.b], all_pts[t.c], p) {
        bad.push(t)
      } else {
        good.push(t)
      }
    }
    // Collect boundary edges of the bad-triangle hole (edges appearing once)
    let all_edges : Array[(Int, Int)] = []
    for t in bad {
      for e in tri_edges(t) {
        all_edges.push(e)
      }
    }
    let boundary : Array[(Int, Int)] = []
    for e in all_edges {
      let mut cnt = 0
      for f in all_edges {
        if edge_eq(e, f) {
          cnt += 1
        }
      }
      if cnt == 1 {
        boundary.push(e)
      }
    }
    // Re-triangulate the hole with point i
    tris.clear()
    for t in good {
      tris.push(t)
    }
    for e in boundary {
      let (u, v) = e
      tris.push(make_tri_ccw(u, v, i, all_pts))
    }
  }
  // Remove triangles that share a vertex with the super-triangle
  let result : Array[TriangleIdx] = []
  for t in tris {
    if t.a < n && t.b < n && t.c < n {
      result.push(t)
    }
  }
  result
}
