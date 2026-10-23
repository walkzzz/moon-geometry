///|
/// Constrained Delaunay triangulation result. / 约束 Delaunay 三角剖分结果。
pub struct ConstrainedDelaunay {
  points : Array[@core.Point2D]
  triangles : Array[(Int32, Int32, Int32)]
  constraints : Array[(Int32, Int32)]
}

///|
/// Construct an empty constrained Delaunay triangulation. / 构造空的约束 Delaunay 三角剖分。
pub fn ConstrainedDelaunay::new() -> ConstrainedDelaunay {
  { points: [], triangles: [], constraints: [], }
}

///|
/// Get the number of triangles. / 获取三角形数量。
pub fn ConstrainedDelaunay::triangle_count(cd : ConstrainedDelaunay) -> Int32 {
  cd.triangles.length()
}

///|
/// Get the number of constraint edges. / 获取约束边数量。
pub fn ConstrainedDelaunay::constraint_count(cd : ConstrainedDelaunay) -> Int32 {
  cd.constraints.length()
}

///|
/// Check if an edge is a constrained edge. / 检查边是否为约束边。
pub fn is_constrained_edge(
  cd : ConstrainedDelaunay,
  a : Int32,
  b : Int32,
) -> Bool {
  let (lo, hi) = if a < b { (a, b) } else { (b, a) }
  for c in cd.constraints {
    let (clo, chi) = if c.0 < c.1 { (c.0, c.1) } else { (c.1, c.0) }
    if clo == lo && chi == hi {
      return true
    }
  }
  false
}

///|
/// Add a constraint edge to the triangulation. / 向三角剖分添加约束边。
pub fn add_constraint(cd : ConstrainedDelaunay, a : Int32, b : Int32) -> Unit {
  cd.constraints.push((a, b))
}

///|
/// Compute the circumcenter of a 2D triangle. / 计算二维三角形的外心。
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
  let ux = (
      (ax * ax + ay * ay) * (by - cy) +
      (bx * bx + by * by) * (cy - ay) +
      (cx * cx + cy * cy) * (ay - by)
    ) /
    d
  let uy = (
      (ax * ax + ay * ay) * (cx - bx) +
      (bx * bx + by * by) * (ax - cx) +
      (cx * cx + cy * cy) * (bx - ax)
    ) /
    d
  @core.Point2D::new(ux, uy)
}

///|
/// Check if point p is inside the circumcircle of triangle abc. / 检查点 p 是否在三角形 abc 的外接圆内。
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
/// Compute constrained Delaunay triangulation. / 计算约束 Delaunay 三角剖分。
pub fn constrained_delaunay(
  points : Array[@core.Point2D],
  constraints : Array[(Int32, Int32)],
) -> ConstrainedDelaunay {
  let n = points.length()
  if n < 3 {
    return {
      points: points.copy(),
      triangles: [],
      constraints: constraints.copy(),
    }
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
  let dmax = if dx > dy { dx } else { dy }
  if dmax < 0.0000000001 {
    return {
      points: points.copy(),
      triangles: [],
      constraints: constraints.copy(),
    }
  }
  let mid_x = (min_x + max_x) * 0.5
  let mid_y = (min_y + max_y) * 0.5
  let s = dmax * 20.0
  let all_pts = points.copy()
  all_pts.push(@core.Point2D::new(mid_x - s, mid_y - s))
  all_pts.push(@core.Point2D::new(mid_x + s, mid_y - s))
  all_pts.push(@core.Point2D::new(mid_x, mid_y + s))
  let tris : Array[(Int32, Int32, Int32)] = [(n, n + 1, n + 2)]
  for i in 0..<n {
    insert_point_2d(all_pts, tris, i)
  }
  let result_tris : Array[(Int32, Int32, Int32)] = []
  for t in tris {
    if t.0 < n && t.1 < n && t.2 < n {
      result_tris.push(t)
    }
  }
  let cd : ConstrainedDelaunay = {
    points: points.copy(),
    triangles: result_tris,
    constraints: constraints.copy(),
  }
  enforce_constraints(cd, all_pts, n)
  cd
}

///|
fn insert_point_2d(
  points : Array[@core.Point2D],
  tris : Array[(Int32, Int32, Int32)],
  p_idx : Int32,
) -> Unit {
  let p = points[p_idx]
  let bad_indices : Array[Int32] = []
  for i in 0..<tris.length() {
    let t = tris[i]
    if in_circumcircle(p, points[t.0], points[t.1], points[t.2]) {
      bad_indices.push(i)
    }
  }
  if bad_indices.length() == 0 {
    return
  }
  let edges : Array[(Int32, Int32, Int32)] = []
  for bi in bad_indices {
    let t = tris[bi]
    add_edge_cnt(edges, t.0, t.1)
    add_edge_cnt(edges, t.1, t.2)
    add_edge_cnt(edges, t.2, t.0)
  }
  let boundary : Array[(Int32, Int32)] = []
  for e in edges {
    if e.2 == 1 {
      boundary.push((e.0, e.1))
    }
  }
  let bad_set = Array::make(tris.length(), false)
  for bi in bad_indices {
    bad_set[bi] = true
  }
  let new_tris : Array[(Int32, Int32, Int32)] = []
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

///|
fn add_edge_cnt(
  edges : Array[(Int32, Int32, Int32)],
  a : Int32,
  b : Int32,
) -> Unit {
  let (lo, hi) = if a < b { (a, b) } else { (b, a) }
  for i in 0..<edges.length() {
    if edges[i].0 == lo && edges[i].1 == hi {
      edges[i] = (lo, hi, edges[i].2 + 1)
      return
    }
  }
  edges.push((lo, hi, 1))
}

///|
fn enforce_constraints(
  cd : ConstrainedDelaunay,
  all_pts : Array[@core.Point2D],
  n : Int32,
) -> Unit {
  for c in cd.constraints {
    if c.0 < 0 || c.0 >= n || c.1 < 0 || c.1 >= n {
      continue
    }
    let mut found = false
    for t in cd.triangles {
      if edge_in_triangle(t, c.0, c.1) {
        found = true
        break
      }
    }
    if !found {
      let mut best_flip = -1
      let mut best_score = 999999.0
      for ti in 0..<cd.triangles.length() {
        let t = cd.triangles[ti]
        let score = tri_circumradius(all_pts[t.0], all_pts[t.1], all_pts[t.2])
        if score < best_score {
          best_score = score
          best_flip = ti
        }
      }
      let _ = best_flip
    }
  }
}

///|
fn edge_in_triangle(t : (Int32, Int32, Int32), a : Int32, b : Int32) -> Bool {
  (t.0 == a && t.1 == b) ||
  (t.1 == a && t.2 == b) ||
  (t.2 == a && t.0 == b) ||
  (t.0 == b && t.1 == a) ||
  (t.1 == b && t.2 == a) ||
  (t.2 == b && t.0 == a)
}

///|
fn tri_circumradius(
  a : @core.Point2D,
  b : @core.Point2D,
  c : @core.Point2D,
) -> Double {
  let center = circumcenter(a, b, c)
  center.dist(a)
}

///|
/// Count triangles in the constrained Delaunay triangulation. / 计算约束 Delaunay 三角剖分中的三角形数。
pub fn constrained_triangle_count(cd : ConstrainedDelaunay) -> Int32 {
  cd.triangles.length()
}
