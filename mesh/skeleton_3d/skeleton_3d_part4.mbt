///|
/// Count 26-connected object neighbors. / 统计 26-连通对象邻居数。
pub fn count_26_neighbors(
  voxels : Array[Bool],
  x : Int,
  y : Int,
  z : Int,
  nx : Int,
  ny : Int,
  nz : Int,
) -> Int {
  let mut count = 0
  for dx in -1..=1 {
    for dy in -1..=1 {
      for dz in -1..=1 {
        if dx == 0 && dy == 0 && dz == 0 {
          continue
        }
        let nx_ = x + dx
        let ny_ = y + dy
        let nz_ = z + dz
        if in_bounds(nx_, ny_, nz_, nx, ny, nz) {
          if voxels[voxel_index(nx_, ny_, nz_, nx, ny)] {
            count += 1
          }
        }
      }
    }
  }
  count
}
