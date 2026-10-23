///|
/// Count object voxels (volume). / 统计对象体素数（体积）。
pub fn skeleton_volume(voxels : Array[Bool]) -> Int32 {
  let mut count = 0
  for v in voxels {
    if v {
      count += 1
    }
  }
  count
}
