///|
/// Tetrahedron in a 3D Delaunay triangulation (vertex indices). / 三维 Delaunay 三角剖分中的四面体（顶点索引）。
pub struct Tetrahedron {
  v0 : Int
  v1 : Int
  v2 : Int
  v3 : Int
}

///|
/// 3D Delaunay triangulation result. / 三维 Delaunay 三角剖分结果。
pub struct Delaunay3D {
  vertices : Array[@core.Point3D]
  tetrahedra : Array[Tetrahedron]
}

///|
/// Construct an empty 3D Delaunay triangulation. / 构造空的三维 Delaunay 三角剖分。
pub fn Delaunay3D::new() -> Delaunay3D {
  { vertices: [], tetrahedra: [] }
}

///|
/// Get the number of tetrahedra. / 获取四面体数量。
pub fn Delaunay3D::tetrahedron_count(d : Delaunay3D) -> Int {
  d.tetrahedra.length()
}

///|
/// Get the number of vertices. / 获取顶点数量。
pub fn Delaunay3D::vertex_count(d : Delaunay3D) -> Int {
  d.vertices.length()
}

///|
/// Compute the signed volume of a tetrahedron. / 计算四面体的有符号体积。
pub fn tetrahedron_volume(
  a : @core.Point3D,
  b : @core.Point3D,
  c : @core.Point3D,
  d : @core.Point3D,
) -> Double {
  let ab = b.sub(a)
  let ac = c.sub(a)
  let ad = d.sub(a)
  ab.dot(ac.cross(ad)) / 6.0
}

///|
/// Compute the circumsphere center of a tetrahedron. / 计算四面体的外接球中心。
pub fn circumsphere_center(
  a : @core.Point3D,
  b : @core.Point3D,
  c : @core.Point3D,
  d : @core.Point3D,
) -> @core.Point3D {
  let ab = b.sub(a)
  let ac = c.sub(a)
  let ad = d.sub(a)
  let m00 = ab.dot(ab)
  let m01 = ab.dot(ac)
  let m02 = ab.dot(ad)
  let m10 = ac.dot(ab)
  let m11 = ac.dot(ac)
  let m12 = ac.dot(ad)
  let m20 = ad.dot(ab)
  let m21 = ad.dot(ac)
  let m22 = ad.dot(ad)
  let r0 = m00 * 0.5
  let r1 = m11 * 0.5
  let r2 = m22 * 0.5
  let det = m00 * (m11 * m22 - m12 * m21) - m01 * (m10 * m22 - m12 * m20) +
    m02 * (m10 * m21 - m11 * m20)
  if det.abs() < 0.0000000001 {
    return @core.Point3D::new(
      (a.x + b.x + c.x + d.x) / 4.0,
      (a.y + b.y + c.y + d.y) / 4.0,
      (a.z + b.z + c.z + d.z) / 4.0,
    )
  }
  let u = (r0 * (m11 * m22 - m12 * m21) - m01 * (r1 * m22 - m12 * r2) +
    m02 * (r1 * m21 - m11 * r2)) / det
  let v = (m00 * (r1 * m22 - m12 * r2) - r0 * (m10 * m22 - m12 * m20) +
    m02 * (m10 * r2 - r1 * m20)) / det
  let w = (m00 * (m11 * r2 - r1 * m21) - m01 * (m10 * r2 - r1 * m20) +
    r0 * (m10 * m21 - m11 * m20)) / det
  a.add(ab.mul(u)).add(ac.mul(v)).add(ad.mul(w))
}

///|
/// Compute the squared circumsphere radius of a tetrahedron. / 计算四面体外接球半径平方。
pub fn circumsphere_radius_sq(
  a : @core.Point3D,
  b : @core.Point3D,
  c : @core.Point3D,
  d : @core.Point3D,
) -> Double {
  let center = circumsphere_center(a, b, c, d)
  center.dist_sq(a)
}

///|
/// Check if a point is inside the circumsphere of a tetrahedron. / 检查点是否在四面体的外接球内。
pub fn in_circumsphere(
  p : @core.Point3D,
  a : @core.Point3D,
  b : @core.Point3D,
  c : @core.Point3D,
  d : @core.Point3D,
) -> Bool {
  let center = circumsphere_center(a, b, c, d)
  let radius_sq = center.dist_sq(a)
  center.dist_sq(p) < radius_sq - 0.0000000001
}

///|
/// Compute 3D Delaunay triangulation via incremental insertion (Bowyer-Watson). / 通过增量插入计算三维 Delaunay 三角剖分（Bowyer-Watson 算法）。
pub fn delaunay_3d(points : Array[@core.Point3D]) -> Delaunay3D {
  let n = points.length()
  if n < 4 {
    return { vertices: points.copy(), tetrahedra: [] }
  }
  let mut min_x = points[0].x
  let mut max_x = points[0].x
  let mut min_y = points[0].y
  let mut max_y = points[0].y
  let mut min_z = points[0].z
  let mut max_z = points[0].z
  for p in points {
    if p.x < min_x {
      min_x = p.x
    }
    if p.x > max_x {
      max_x = p.x
    }
    if p.y < min_y {
      min_y = p.y
    }
    if p.y > max_y {
      max_y = p.y
    }
    if p.z < min_z {
      min_z = p.z
    }
    if p.z > max_z {
      max_z = p.z
    }
  }
  let dx = max_x - min_x
  let dy = max_y - min_y
  let dz = max_z - min_z
  let dmax = if dx > dy {
    if dx > dz {
      dx
    } else {
      dz
    }
  } else if dy > dz {
    dy
  } else {
    dz
  }
  if dmax < 0.0000000001 {
    return { vertices: points.copy(), tetrahedra: [] }
  }
  let mid_x = (min_x + max_x) * 0.5
  let mid_y = (min_y + max_y) * 0.5
  let mid_z = (min_z + max_z) * 0.5
  let s = dmax * 20.0
  let super_v0 = @core.Point3D::new(mid_x - s, mid_y - s, mid_z - s)
  let super_v1 = @core.Point3D::new(mid_x + s, mid_y + s, mid_z - s)
  let super_v2 = @core.Point3D::new(mid_x + s, mid_y - s, mid_z + s)
  let super_v3 = @core.Point3D::new(mid_x - s, mid_y + s, mid_z + s)
  let all_points = points.copy()
  all_points.push(super_v0)
  all_points.push(super_v1)
  all_points.push(super_v2)
  all_points.push(super_v3)
  let tets : Array[Tetrahedron] = [
    { v0: n, v1: n + 1, v2: n + 2, v3: n + 3 },
  ]
  for i in 0..<n {
    insert_point(all_points, tets, i)
  }
  let result_tets : Array[Tetrahedron] = []
  for t in tets {
    if t.v0 < n && t.v1 < n && t.v2 < n && t.v3 < n {
      result_tets.push(t)
    }
  }
  { vertices: points.copy(), tetrahedra: result_tets }
}

fn insert_point(
  points : Array[@core.Point3D],
  tets : Array[Tetrahedron],
  p_idx : Int,
) -> Unit {
  let p = points[p_idx]
  let bad_indices : Array[Int] = []
  for i in 0..<tets.length() {
    let t = tets[i]
    let a = points[t.v0]
    let b = points[t.v1]
    let c = points[t.v2]
    let d = points[t.v3]
    if in_circumsphere(p, a, b, c, d) {
      bad_indices.push(i)
    }
  }
  if bad_indices.length() == 0 {
    return
  }
  let faces : Array[(Int, Int, Int, Int)] = []
  for bi in bad_indices {
    let t = tets[bi]
    add_face(faces, t.v0, t.v1, t.v2)
    add_face(faces, t.v0, t.v1, t.v3)
    add_face(faces, t.v0, t.v2, t.v3)
    add_face(faces, t.v1, t.v2, t.v3)
  }
  let boundary : Array[(Int, Int, Int)] = []
  for f in faces {
    if f.3 == 1 {
      boundary.push((f.0, f.1, f.2))
    }
  }
  let bad_set = Array::make(tets.length(), false)
  for bi in bad_indices {
    bad_set[bi] = true
  }
  let new_tets : Array[Tetrahedron] = []
  for i in 0..<tets.length() {
    if !bad_set[i] {
      new_tets.push(tets[i])
    }
  }
  tets.clear()
  for t in new_tets {
    tets.push(t)
  }
  for f in boundary {
    tets.push({ v0: f.0, v1: f.1, v2: f.2, v3: p_idx })
  }
}

fn add_face(
  faces : Array[(Int, Int, Int, Int)],
  a : Int,
  b : Int,
  c : Int,
) -> Unit {
  let (i0, i1, i2) = sort3(a, b, c)
  for i in 0..<faces.length() {
    if faces[i].0 == i0 && faces[i].1 == i1 && faces[i].2 == i2 {
      faces[i] = (i0, i1, i2, faces[i].3 + 1)
      return
    }
  }
  faces.push((i0, i1, i2, 1))
}

fn sort3(a : Int, b : Int, c : Int) -> (Int, Int, Int) {
  let (a1, b1) = if a <= b {
    (a, b)
  } else {
    (b, a)
  }
  let (a2, c1) = if a1 <= c {
    (a1, c)
  } else {
    (c, a1)
  }
  let (b2, c2) = if b1 <= c1 {
    (b1, c1)
  } else {
    (c1, b1)
  }
  (a2, b2, c2)
}

///|
/// Check if the triangulation satisfies the Delaunay property. / 检查三角剖分是否满足 Delaunay 性质。
pub fn is_delaunay(d : Delaunay3D) -> Bool {
  for t in d.tetrahedra {
    let a = d.vertices[t.v0]
    let b = d.vertices[t.v1]
    let c = d.vertices[t.v2]
    let e = d.vertices[t.v3]
    let center = circumsphere_center(a, b, c, e)
    let radius_sq = center.dist_sq(a)
    for i in 0..<d.vertices.length() {
      if i == t.v0 || i == t.v1 || i == t.v2 || i == t.v3 {
        continue
      }
      if center.dist_sq(d.vertices[i]) < radius_sq - 0.0000001 {
        return false
      }
    }
  }
  true
}