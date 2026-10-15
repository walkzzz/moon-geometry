///|
/// A triangle as three vertex indices into a point array.
/// 表示为点数组中三个顶点索引的三角形。
pub struct TriangleIdx {
  a : Int
  b : Int
  c : Int
} derive(Debug)

///|
/// Normalize an edge so the smaller index comes first.
/// 规范化边，使较小索引在前。
fn norm_edge(a : Int, b : Int) -> (Int, Int) {
  if a < b {
    (a, b)
  } else {
    (b, a)
  }
}

///|
/// Edges of a triangle as normalized index pairs.
/// 三角形的边，以规范化索引对表示。
fn tri_edges(t : TriangleIdx) -> Array[(Int, Int)] {
  [norm_edge(t.a, t.b), norm_edge(t.b, t.c), norm_edge(t.c, t.a)]
}

///|
/// Whether two index pairs are equal.
/// 两个索引对是否相等。
fn edge_eq(e1 : (Int, Int), e2 : (Int, Int)) -> Bool {
  let (a1, b1) = e1
  let (a2, b2) = e2
  a1 == a2 && b1 == b2
}

///|
/// In-circumcircle test via determinant. Assumes triangle (a,b,c) is CCW.
/// 通过行列式进行外接圆判定。假设三角形 (a,b,c) 为逆时针。
/// Returns true if point d lies strictly inside the circumcircle of a,b,c.
/// 当点 d 严格在 a,b,c 外接圆内时返回 true。
fn in_circumcircle(
  a : @core.Point2D,
  b : @core.Point2D,
  c : @core.Point2D,
  d : @core.Point2D
) -> Bool {
  let ax = a.x - d.x
  let ay = a.y - d.y
  let bx = b.x - d.x
  let by = b.y - d.y
  let cx = c.x - d.x
  let cy = c.y - d.y
  let aa = ax * ax + ay * ay
  let bb = bx * bx + by * by
  let cc = cx * cx + cy * cy
  let det = ax * (by * cc - cy * bb) - ay * (bx * cc - cx * bb) + aa * (bx * cy - by * cx)
  det > 0.0
}

///|
/// Build a triangle from indices, ensuring CCW orientation.
/// 从索引构造三角形，确保逆时针方向。
fn make_tri_ccw(
  i : Int,
  j : Int,
  k : Int,
  pts : Array[@core.Point2D]
) -> TriangleIdx {
  if @core.turn(pts[i], pts[j], pts[k]) < 0.0 {
    { a: i, b: k, c: j }
  } else {
    { a: i, b: j, c: k }
  }
}

///|
/// Delaunay triangulation via Bowyer-Watson incremental insertion. O(n^2) expected.
/// Bowyer-Watson 增量插入法 Delaunay 三角剖分。期望 O(n^2)。
/// Returns an array of triangles as vertex index triples (CCW).
/// 返回逆时针顶点索引三元组数组。
pub fn delaunay_triangulation(points : Array[@core.Point2D]) -> Array[TriangleIdx] {
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

///|
pub extend TriangleIdx with @moonbitlang/core/debug.Debug::{to_repr}

///|
/// Voronoi diagram from Delaunay triangulation (duality).
/// 从 Delaunay 三角剖分构造 Voronoi 图（对偶）。
/// Returns (vertices, edges) where vertices are circumcenters of Delaunay
/// 返回 (顶点, 边)，顶点为 Delaunay
/// triangles and edges connect circumcenters of adjacent triangles.
/// 三角形的外心，边连接相邻三角形的外心。
pub fn voronoi_diagram(
  points : Array[@core.Point2D]
) -> (Array[@core.Point2D], Array[(Int, Int)]) {
  let tris = delaunay_triangulation(points)
  let vertices : Array[@core.Point2D] = []
  for t in tris {
    let tri = @core.Triangle::new(points[t.a], points[t.b], points[t.c])
    vertices.push(tri.circumcenter())
  }
  // Edges: for each pair of triangles sharing an edge, connect their circumcenters
  let edges : Array[(Int, Int)] = []
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