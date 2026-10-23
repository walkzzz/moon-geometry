///|
pub fn voxel_count_occupied(grid : VoxelGrid) -> Int {
  let mut count = 0
  for i in 0..<grid.data.length() {
    if grid.data[i] {
      count += 1
    }
  }
  count
}
