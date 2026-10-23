///|
/// Count 6-connected object neighbors. / 统计 6-连通对象邻居数。
pub fn count_6_neighbors(
  voxels : Array[Bool],
  x : Int,
  y : Int,
  z : Int,
  nx : Int,
  ny : Int,
  nz : Int,
) -> Int {
  let mut count = 0
  let offsets = [(1, 0, 0), (-1, 0, 0), (0, 1, 0), (0, -1, 0), (0, 0, 1), (0, 0, -1)]
  for off in offsets {
    let (dx, dy, dz) = off
    let nx_ = x + dx
    let ny_ = y + dy
    let nz_ = z + dz
    if in_bounds(nx_, ny_, nz_, nx, ny, nz) {
      if voxels[voxel_index(nx_, ny_, nz_, nx, ny)] {
        count += 1
      }
    }
  }
  count
}
