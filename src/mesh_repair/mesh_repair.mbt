///|
/// Mesh repair result. / 网格修复结果。
pub struct MeshRepairResult {
  vertices : Array[@core.Point3D]
  faces : Array[(Int, Int, Int)]
  holes_filled : Int
  degenerate_removed : Int
  non_manifold_fixed : Int
}

///|
/// Construct repair result. / 构造修复结果。
pub fn MeshRepairResult::new(
  vertices : Array[@core.Point3D],
  faces : Array[(Int, Int, Int)],
  holes_filled : Int,
  degenerate_removed : Int,
  non_manifold_fixed : Int,
) -> MeshRepairResult {
  { vertices, faces, holes_filled, degenerate_removed, non_manifold_fixed }
}

///|
/// Remove degenerate triangles (zero area). / 移除退化三角形（零面积）。
pub fn remove_degenerate_faces(
  vertices : Array[@core.Point3D],
  faces : Array[(Int, Int, Int)],
  eps : Double,
) -> (Array[(Int, Int, Int)], Int) {
  let result : Array[(Int, Int, Int)] = []
  let mut removed = 0
  for f in faces {
    let p0 = vertices[f.0]
    let p1 = vertices[f.1]
    let p2 = vertices[f.2]
    let v1 = p1.sub(p0)
    let v2 = p2.sub(p0)
    let cross = v1.cross(v2)
    let area_sq = cross.x * cross.x + cross.y * cross.y + cross.z * cross.z
    if area_sq > eps * eps {
      result.push(f)
    } else {
      removed += 1
    }
  }
  (result, removed)
}

///|
/// Remove duplicate vertices (merge within tolerance). / 移除重复顶点（容差内合并）。
pub fn merge_duplicate_vertices(
  vertices : Array[@core.Point3D],
  faces : Array[(Int, Int, Int)],
  eps : Double,
) -> (Array[@core.Point3D], Array[(Int, Int, Int)], Int) {
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
  let new_faces : Array[(Int, Int, Int)] = []
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

///|
/// Find boundary edges (edges used by only one face). / 查找边界边（仅被一个面使用的边）。
pub fn find_boundary_edges(
  faces : Array[(Int, Int, Int)],
) -> Array[(Int, Int)] {
  let edge_count : Array[((Int, Int), Int)] = []
  for f in faces {
    add_edge_count(edge_count, f.0, f.1)
    add_edge_count(edge_count, f.1, f.2)
    add_edge_count(edge_count, f.2, f.0)
  }
  let boundary : Array[(Int, Int)] = []
  for entry in edge_count {
    if entry.1 == 1 {
      boundary.push(entry.0)
    }
  }
  boundary
}

fn add_edge_count(edges : Array[((Int, Int), Int)], a : Int, b : Int) -> Unit {
  let (x, y) = if a < b { (a, b) } else { (b, a) }
  for i in 0..<edges.length() {
    if edges[i].0.0 == x && edges[i].0.1 == y {
      edges[i] = ((x, y), edges[i].1 + 1)
      return
    }
  }
  edges.push(((x, y), 1))
}

///|
/// Fill simple holes (single triangle fan). / 填充简单孔洞（单三角扇）。
pub fn fill_holes(
  _vertices : Array[@core.Point3D],
  faces : Array[(Int, Int, Int)],
) -> (Array[(Int, Int, Int)], Int) {
  let boundary = find_boundary_edges(faces)
  if boundary.length() < 3 {
    return (faces, 0)
  }
  let new_faces : Array[(Int, Int, Int)] = []
  for f in faces {
    new_faces.push(f)
  }
  let v0 = boundary[0].0
  let mut filled = 0
  for i in 1..<boundary.length() {
    let v1 = boundary[i].0
    let v2 = boundary[i].1
    if v0 != v1 && v1 != v2 && v0 != v2 {
      new_faces.push((v0, v1, v2))
      filled += 1
    }
  }
  (new_faces, filled)
}

///|
/// Full mesh repair pipeline. / 完整网格修复流水线。
pub fn repair_mesh(
  vertices : Array[@core.Point3D],
  faces : Array[(Int, Int, Int)],
  eps : Double,
) -> MeshRepairResult {
  let (faces1, deg_removed) = remove_degenerate_faces(vertices, faces, eps)
  let (verts2, faces2, merged) = merge_duplicate_vertices(vertices, faces1, eps)
  let (faces3, holes) = fill_holes(verts2, faces2)
  { vertices: verts2, faces: faces3, holes_filled: holes, degenerate_removed: deg_removed, non_manifold_fixed: merged }
}