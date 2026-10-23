///|
/// Check if a voxel is deletable (simple point, simplified criterion).
/// 检查体素是否可删除（简化简单点判据）。
///
/// A voxel is deletable if it is a boundary voxel, has at least 2 object
/// 6-neighbors (not an endpoint), and fewer than 6 (not fully interior).
/// 体素为边界体素、对象 6-邻居数 >= 2（非端点）且 < 6（非完全内部）时可删除。
fn is_deletable(
  voxels : Array[Bool],
  x : Int32,
  y : Int32,
  z : Int32,
  nx : Int32,
  ny : Int32,
  nz : Int32,
) -> Bool {
  if !is_boundary(voxels, x, y, z, nx, ny, nz) {
    return false
  }
  let n = count_6_neighbors(voxels, x, y, z, nx, ny, nz)
  n >= 2 && n < 6
}
