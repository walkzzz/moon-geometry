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
