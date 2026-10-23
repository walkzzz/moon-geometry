///|
/// Electric field method skeleton: voxels with high field divergence.
/// 电场法骨架：场散度较高的体素。
///
/// Simplified: keep voxels that are local maxima of the distance transform
/// (approximated by neighbor count). / 简化：保留距离变换局部极大值体素。
pub fn skeleton_field(
  voxels : Array[Bool],
  nx : Int,
  ny : Int,
  nz : Int,
) -> Array[Bool] {
  let result : Array[Bool] = Array::make(voxels.length(), false)
  for z in 0..<nz {
    for y in 0..<ny {
      for x in 0..<nx {
        let idx = voxel_index(x, y, z, nx, ny)
        if voxels[idx] {
          let n = count_26_neighbors(voxels, x, y, z, nx, ny, nz)
          if n <= 6 {
            result[idx] = true
          }
        }
      }
    }
  }
  result
}