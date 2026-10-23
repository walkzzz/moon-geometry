///|
/// Check if the mesh is a valid torus (χ = 0). / 检查网格是否为环面（χ = 0）。
pub fn is_torus(mesh : @mesh_data.Mesh) -> Bool {
  euler_characteristic(mesh) == 0
}


///|
/// Compute the Euler characteristic from component counts. / 由分量计数计算欧拉示性数。
pub fn euler_from_counts(
  vertices : Int,
  edges : Int,
  faces : Int,
) -> Int {
  vertices - edges + faces
}
