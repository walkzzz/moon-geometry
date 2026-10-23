///|
/// Mesh repair result. / 网格修复结果。
pub struct MeshRepairResult {
  vertices : Array[@core.Point3D]
  faces : Array[(Int32, Int32, Int32)]
  holes_filled : Int32
  degenerate_removed : Int32
  non_manifold_fixed : Int32
}

///|
/// Construct repair result. / 构造修复结果。
pub fn MeshRepairResult::new(
  vertices : Array[@core.Point3D],
  faces : Array[(Int32, Int32, Int32)],
  holes_filled : Int32,
  degenerate_removed : Int32,
  non_manifold_fixed : Int32,
) -> MeshRepairResult {
  { vertices, faces, holes_filled, degenerate_removed, non_manifold_fixed, }
}

///|
/// Remove degenerate triangles (zero area). / 移除退化三角形（零面积）。
pub fn remove_degenerate_faces(
  vertices : Array[@core.Point3D],
  faces : Array[(Int32, Int32, Int32)],
  eps : Double,
) -> (Array[(Int32, Int32, Int32)], Int32) {
  let result : Array[(Int32, Int32, Int32)] = []
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
