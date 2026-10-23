///|
/// Check if a voxel is a boundary voxel (has at least one background 6-neighbor).
/// 检查体素是否为边界体素（至少有一个背景 6-邻居）。
pub fn is_boundary(
  voxels : Array[Bool],
  x : Int,
  y : Int,
  z : Int,
  nx : Int,
  ny : Int,
  nz : Int,
) -> Bool {
  let offsets = [(1, 0, 0), (-1, 0, 0), (0, 1, 0), (0, -1, 0), (0, 0, 1), (0, 0, -1)]
  for off in offsets {
    let (dx, dy, dz) = off
    let nx_ = x + dx
    let ny_ = y + dy
    let nz_ = z + dz
    if !in_bounds(nx_, ny_, nz_, nx, ny, nz) {
      return true
    }
    if !voxels[voxel_index(nx_, ny_, nz_, nx, ny)] {
      return true
    }
  }
  false
}
