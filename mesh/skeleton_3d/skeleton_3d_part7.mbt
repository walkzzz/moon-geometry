///|
/// 3D skeleton via iterative surface thinning.
/// 通过迭代表面细化提取三维骨架。
///
/// # Arguments / 参数
/// - `voxels`: flattened 3D voxel grid / 展平三维体素网格
/// - `nx`, `ny`, `nz`: grid dimensions / 网格维度
///
/// Returns the thinned skeleton voxel grid.
/// 返回细化后的骨架体素网格。
pub fn skeleton_3d(
  voxels : Array[Bool],
  nx : Int32,
  ny : Int32,
  nz : Int32,
) -> Array[Bool] {
  let result : Array[Bool] = []
  for v in voxels {
    result.push(v)
  }
  let mut changed = true
  while changed {
    changed = false
    let to_remove : Array[Int32] = []
    for z in 0..<nz {
      for y in 0..<ny {
        for x in 0..<nx {
          let idx = voxel_index(x, y, z, nx, ny)
          if result[idx] {
            if is_deletable(result, x, y, z, nx, ny, nz) {
              to_remove.push(idx)
            }
          }
        }
      }
    }
    if to_remove.length() > 0 {
      changed = true
      for idx in to_remove {
        result[idx] = false
      }
    }
  }
  result
}
