///|
/// A simplex in the alpha complex. / Alpha 复形中的单纯形。
pub struct AlphaSimplex {
  vertices : Array[Int]
  dimension : Int
  circumradius : Double
}

///|
/// Alpha complex: subcomplex of Delaunay filtered by circumradius. / Alpha 复形：按外接圆半径过滤的 Delaunay 子复形。
pub struct AlphaComplex {
  simplices : Array[AlphaSimplex]
  alpha : Double
}

///|
/// Construct an empty alpha complex. / 构造空的 Alpha 复形。
pub fn AlphaComplex::new() -> AlphaComplex {
  { simplices: [], alpha: 0.0 }
}

///|
/// Get the number of simplices. / 获取单纯形数量。
pub fn AlphaComplex::simplex_count(ac : AlphaComplex) -> Int {
  ac.simplices.length()
}

///|
/// Compute circumcenter of a 2D triangle. / 计算二维三角形的外心。
fn circumcenter(
  a : @core.Point2D,
  b : @core.Point2D,
  c : @core.Point2D,
) -> @core.Point2D {
  let ax = a.x()
  let ay = a.y()
  let bx = b.x()
  let by = b.y()
  let cx = c.x()
  let cy = c.y()
  let d = 2.0 * (ax * (by - cy) + bx * (cy - ay) + cx * (ay - by))
  if d.abs() < 0.0000000001 {
    return @core.Point2D::new((ax + bx + cx) / 3.0, (ay + by + cy) / 3.0)
  }
  let ux = ((ax * ax + ay * ay) * (by - cy) + (bx * bx + by * by) * (cy - ay) +
    (cx * cx + cy * cy) * (ay - by)) / d
  let uy = ((ax * ax + ay * ay) * (cx - bx) + (bx * bx + by * by) * (ax - cx) +
    (cx * cx + cy * cy) * (bx - ax)) / d
  @core.Point2D::new(ux, uy)
}

///|
/// Check if point p is inside circumcircle of triangle abc. / 检查点 p 是否在三角形 abc 的外接圆内。
fn in_circumcircle(
  p : @core.Point2D,
  a : @core.Point2D,
  b : @core.Point2D,
  c : @core.Point2D,
) -> Bool {
  let center = circumcenter(a, b, c)
  let rsq = center.dist_sq(a)
  center.dist_sq(p) < rsq - 0.0000000001
}

///|
/// Compute 2D Delaunay triangulation (Bowyer-Watson). / 计算二维 Delaunay 三角剖分（Bowyer-Watson 算法）。
fn delaunay_2d(
  points : Array[@core.Point2D],
) -> Array[(Int, Int, Int)] {
  let n = points.length()
  if n < 3 {
    return []
  }
  let mut min_x = points[0].x()
  let mut max_x = points[0].x()
  let mut min_y = points[0].y()
  let mut max_y = points[0].y()
  for p in points {
    if p.x() < min_x {
      min_x = p.x()
    }
    if p.x() > max_x {
      max_x = p.x()
    }
    if p.y() < min_y {
      min_y = p.y()
    }
    if p.y() > max_y {
      max_y = p.y()
    }
  }
  let dx = max_x - min_x
  let dy = max_y - min_y
  let dmax = if dx > dy {
    dx
  } else {
    dy
  }
  if dmax < 0.0000000001 {
    return []
  }
  let mid_x = (min_x + max_x) * 0.5
  let mid_y = (min_y + max_y) * 0.5
  let s = dmax * 20.0
  let all_pts = points.copy()
  all_pts.push(@core.Point2D::new(mid_x - s, mid_y - s))
  all_pts.push(@core.Point2D::new(mid_x + s, mid_y - s))
  all_pts.push(@core.Point2D::new(mid_x, mid_y + s))
  let tris : Array[(Int, Int, Int)] = [(n, n + 1, n + 2)]
  for i in 0..<n {
    insert_pt(all_pts, tris, i)
  }
  let result : Array[(Int, Int, Int)] = []
  for t in tris {
    if t.0 < n && t.1 < n && t.2 < n {
      result.push(t)
    }
  }
  result
}

fn insert_pt(
  points : Array[@core.Point2D],
  tris : Array[(Int, Int, Int)],
  p_idx : Int,
) -> Unit {
  let p = points[p_idx]
  let bad : Array[Int] = []
  for i in 0..<tris.length() {
    let t = tris[i]
    if in_circumcircle(p, points[t.0], points[t.1], points[t.2]) {
      bad.push(i)
    }
  }
  if bad.length() == 0 {
    return
  }
  let edges : Array[(Int, Int, Int)] = []
  for bi in bad {
    let t = tris[bi]
    add_e(edges, t.0, t.1)
    add_e(edges, t.1, t.2)
    add_e(edges, t.2, t.0)
  }
  let boundary : Array[(Int, Int)] = []
  for e in edges {
    if e.2 == 1 {
      boundary.push((e.0, e.1))
    }
  }
  let bad_set = Array::make(tris.length(), false)
  for bi in bad {
    bad_set[bi] = true
  }
  let new_tris : Array[(Int, Int, Int)] = []
  for i in 0..<tris.length() {
    if !bad_set[i] {
      new_tris.push(tris[i])
    }
  }
  tris.clear()
  for t in new_tris {
    tris.push(t)
  }
  for e in boundary {
    tris.push((e.0, e.1, p_idx))
  }
}

fn add_e(edges : Array[(Int, Int, Int)], a : Int, b : Int) -> Unit {
  let (lo, hi) = if a < b {
    (a, b)
  } else {
    (b, a)
  }
  for i in 0..<edges.length() {
    if edges[i].0 == lo && edges[i].1 == hi {
      edges[i] = (lo, hi, edges[i].2 + 1)
      return
    }
  }
  edges.push((lo, hi, 1))
}

///|
/// Check if a simplex is alpha-exposed (circumradius <= alpha). / 检查单纯形是否为 Alpha 暴露（外接圆半径 <= alpha）。
pub fn is_alpha_exposed(simplex : AlphaSimplex, alpha : Double) -> Bool {
  simplex.circumradius <= alpha + 0.0000000001
}

///|
/// Compute the alpha complex of a 2D point set. / 计算二维点集的 Alpha 复形。
pub fn alpha_complex(
  points : Array[@core.Point2D],
  alpha : Double,
) -> AlphaComplex {
  let n = points.length()
  if n == 0 {
    return { simplices: [], alpha }
  }
  let simplices : Array[AlphaSimplex] = []
  for i in 0..<n {
    simplices.push({ vertices: [i], dimension: 0, circumradius: 0.0 })
  }
  for i in 0..<n {
    for j in (i + 1)..<n {
      let mid = @core.Point2D::new(
        (points[i].x() + points[j].x()) / 2.0,
        (points[i].y() + points[j].y()) / 2.0,
      )
      let radius = mid.dist(points[i])
      if radius <= alpha + 0.0000000001 {
        simplices.push({ vertices: [i, j], dimension: 1, circumradius: radius })
      }
    }
  }
  let tris = delaunay_2d(points)
  for t in tris {
    let center = circumcenter(points[t.0], points[t.1], points[t.2])
    let radius = center.dist(points[t.0])
    if radius <= alpha + 0.0000000001 {
      simplices.push({
        vertices: [t.0, t.1, t.2],
        dimension: 2,
        circumradius: radius,
      })
    }
  }
  { simplices, alpha }
}

///|
/// Compute the alpha shape (boundary edges of the alpha complex). / 计算 Alpha 形（Alpha 复形的边界边）。
pub fn alpha_shape(
  points : Array[@core.Point2D],
  alpha : Double,
) -> Array[(Int, Int)] {
  let ac = alpha_complex(points, alpha)
  let edge_count : Array[(Int, Int, Int)] = []
  for s in ac.simplices {
    if s.dimension == 1 && s.vertices.length() == 2 {
      let a = s.vertices[0]
      let b = s.vertices[1]
      let (lo, hi) = if a < b {
        (a, b)
      } else {
        (b, a)
      }
      add_e(edge_count, lo, hi)
    }
    if s.dimension == 2 && s.vertices.length() == 3 {
      let v = s.vertices
      add_e(edge_count, v[0], v[1])
      add_e(edge_count, v[1], v[2])
      add_e(edge_count, v[2], v[0])
    }
  }
  let boundary : Array[(Int, Int)] = []
  for e in edge_count {
    if e.2 == 1 {
      boundary.push((e.0, e.1))
    }
  }
  boundary
}

///|
/// Count simplices in the alpha complex. / 计算 Alpha 复形中的单纯形数。
pub fn alpha_complex_count(ac : AlphaComplex) -> Int {
  ac.simplices.length()
}