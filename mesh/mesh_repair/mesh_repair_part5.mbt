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