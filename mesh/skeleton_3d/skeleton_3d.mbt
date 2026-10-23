///|
/// # 3D Skeleton (Surface Thinning)
/// # 三维骨架（表面细化）
///
/// Thinning of a 3D voxel grid to extract a skeleton preserving topology.
/// 三维体素网格的细化以提取保持拓扑的骨架。
///
/// ## Complexity: O(iter * nx * ny * nz)
/// ## 复杂度: O(iter * nx * ny * nz)


///|
/// Voxel index in flattened 3D grid. / 展平三维网格中的体素索引。
pub fn voxel_index(
  x : Int,
  y : Int,
  z : Int,
  nx : Int,
  ny : Int,
) -> Int {
  x + y * nx + z * nx * ny
}
