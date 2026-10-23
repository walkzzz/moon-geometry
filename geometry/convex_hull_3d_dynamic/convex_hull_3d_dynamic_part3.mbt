///|
/// Compute 3D convex hull using incremental insertion. / 使用增量插入计算3D凸包。
pub fn compute_hull_3d(points : Array[@core.Point3D]) -> Array[(Int, Int, Int)] {
  let n = points.length()
  if n < 4 {
    return []
  }
  let i0 = 0
  let mut i1 = 1
  while i1 < n && points[i0].dist_sq(points[i1]) < 0.0000000001 {
    i1 += 1
  }
  if i1 >= n {
    return []
  }
  let mut i2 = 2
  while i2 < n {
    let v1 = points[i1].sub(points[i0])
    let v2 = points[i2].sub(points[i0])
    let cross = v1.cross(v2)
    if cross.x * cross.x + cross.y * cross.y + cross.z * cross.z > 0.0000000001 {
      break
    }
    i2 += 1
  }
  if i2 >= n {
    return []
  }
  let mut i3 = 3
  while i3 < n {
    let v1 = points[i1].sub(points[i0])
    let v2 = points[i2].sub(points[i0])
    let v3 = points[i3].sub(points[i0])
    let det = v1.dot(v2.cross(v3))
    if det.abs() > 0.0000000001 {
      break
    }
    i3 += 1
  }
  if i3 >= n {
    return []
  }
  let v1 = points[i1].sub(points[i0])
  let v2 = points[i2].sub(points[i0])
  let v3 = points[i3].sub(points[i0])
  let det = v1.dot(v2.cross(v3))
  let faces : Array[(Int, Int, Int)] = []
  if det > 0.0 {
    faces.push((i0, i2, i1))
    faces.push((i0, i1, i3))
    faces.push((i0, i3, i2))
    faces.push((i1, i2, i3))
  } else {
    faces.push((i0, i1, i2))
    faces.push((i0, i3, i1))
    faces.push((i0, i2, i3))
    faces.push((i1, i3, i2))
  }
  let inside : Array[Bool] = Array::make(n, true)
  inside[i0] = false
  inside[i1] = false
  inside[i2] = false
  inside[i3] = false
  for i in 0..<n {
    if !inside[i] {
      continue
    }
    let visible : Array[Int] = []
    for j in 0..<faces.length() {
      let f = faces[j]
      let a = points[f.0]
      let b = points[f.1]
      let c = points[f.2]
      let normal = b.sub(a).cross(c.sub(a))
      let to_point = points[i].sub(a)
      if normal.dot(to_point) > 0.0000000001 {
        visible.push(j)
      }
    }
    if visible.length() == 0 {
      continue
    }
    inside[i] = false
    let boundary : Array[(Int, Int)] = []
    let removed = Array::make(faces.length(), false)
    for j in visible {
      removed[j] = true
      let f = faces[j]
      add_boundary_edge(boundary, f.0, f.1)
      add_boundary_edge(boundary, f.1, f.2)
      add_boundary_edge(boundary, f.2, f.0)
    }
    let new_faces : Array[(Int, Int, Int)] = []
    for j in 0..<faces.length() {
      if !removed[j] {
        new_faces.push(faces[j])
      }
    }
    for edge in boundary {
      new_faces.push((edge.0, edge.1, i))
    }
    faces.clear()
    for f in new_faces {
      faces.push(f)
    }
  }
  faces
}

fn add_boundary_edge(boundary : Array[(Int, Int)], a : Int, b : Int) -> Unit {
  let mut found = false
  let mut idx = -1
  for j in 0..<boundary.length() {
    if boundary[j].0 == b && boundary[j].1 == a {
      found = true
      idx = j
      break
    }
  }
  if found {
    ignore(boundary.remove(idx))
  } else {
    boundary.push((a, b))
  }
}
