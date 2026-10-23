///|
/// Compute 2D Delaunay triangulation (Bowyer-Watson). / 计算二维 Delaunay 三角剖分（Bowyer-Watson 算法）。
fn delaunay_2d(points : Array[@core.Point2D]) -> Array[(Int32, Int32, Int32)] {
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
  let dmax = if dx > dy { dx } else { dy }
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
  let tris : Array[(Int32, Int32, Int32)] = [(n, n + 1, n + 2)]
  for i in 0..<n {
    insert_pt(all_pts, tris, i)
  }
  let result : Array[(Int32, Int32, Int32)] = []
  for t in tris {
    if t.0 < n && t.1 < n && t.2 < n {
      result.push(t)
    }
  }
  result
}

///|
fn insert_pt(
  points : Array[@core.Point2D],
  tris : Array[(Int32, Int32, Int32)],
  p_idx : Int32,
) -> Unit {
  let p = points[p_idx]
  let bad : Array[Int32] = []
  for i in 0..<tris.length() {
    let t = tris[i]
    if in_circumcircle(p, points[t.0], points[t.1], points[t.2]) {
      bad.push(i)
    }
  }
  if bad.length() == 0 {
    return
  }
  let edges : Array[(Int32, Int32, Int32)] = []
  for bi in bad {
    let t = tris[bi]
    add_e(edges, t.0, t.1)
    add_e(edges, t.1, t.2)
    add_e(edges, t.2, t.0)
  }
  let boundary : Array[(Int32, Int32)] = []
  for e in edges {
    if e.2 == 1 {
      boundary.push((e.0, e.1))
    }
  }
  let bad_set = Array::make(tris.length(), false)
  for bi in bad {
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
fn add_e(edges : Array[(Int32, Int32, Int32)], a : Int32, b : Int32) -> Unit {
  let (lo, hi) = if a < b { (a, b) } else { (b, a) }
  for i in 0..<edges.length() {
    if edges[i].0 == lo && edges[i].1 == hi {
      edges[i] = (lo, hi, edges[i].2 + 1)
      return
    }
  }
  edges.push((lo, hi, 1))
}
