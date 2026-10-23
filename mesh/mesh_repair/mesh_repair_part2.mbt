///|
/// Remove duplicate vertices (merge within tolerance). / 移除重复顶点（容差内合并）。
pub fn merge_duplicate_vertices(
  vertices : Array[@core.Point3D],
  faces : Array[(Int32, Int32, Int32)],
  eps : Double,
) -> (Array[@core.Point3D], Array[(Int32, Int32, Int32)], Int32) {
  let n = vertices.length()
  let mapping = Array::make(n, -1)
  let new_verts : Array[@core.Point3D] = []
  let mut merged = 0
  for i in 0..<n {
    let mut found = -1
    for j in 0..<new_verts.length() {
      if vertices[i].dist_sq(new_verts[j]) <= eps * eps {
        found = j
        break
      }
    }
    if found >= 0 {
      mapping[i] = found
      merged += 1
    } else {
      mapping[i] = new_verts.length()
      new_verts.push(vertices[i])
    }
  }
  let new_faces : Array[(Int32, Int32, Int32)] = []
  for f in faces {
    let a = mapping[f.0]
    let b = mapping[f.1]
    let c = mapping[f.2]
    if a != b && b != c && a != c {
      new_faces.push((a, b, c))
    }
  }
  (new_verts, new_faces, merged)
}
