///|
/// Count skeleton endpoints (object voxels with exactly 1 object 6-neighbor).
/// 统计骨架端点（对象 6-邻居数恰为 1 的体素）。
pub fn skeleton_endpoints(
  voxels : Array[Bool],
  nx : Int,
  ny : Int,
  nz : Int,
) -> Int {
  let mut count = 0
  for z in 0..<nz {
    for y in 0..<ny {
      for x in 0..<nx {
        let idx = voxel_index(x, y, z, nx, ny)
        if voxels[idx] {
          if count_6_neighbors(voxels, x, y, z, nx, ny, nz) == 1 {
            count += 1
          }
        }
      }
    }
  }
  count
}
