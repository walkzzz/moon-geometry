///|
pub fn voxel_set(grid : VoxelGrid, p : @core.Point3D) -> VoxelGrid {
  let idx = voxel_index(grid, p)
  if idx >= 0 && idx < grid.data.length() {
    let new_data = Array::make(grid.data.length(), false)
    for i in 0..<grid.data.length() {
      new_data[i] = grid.data[i]
    }
    new_data[idx] = true
    return { ..grid, data: new_data }
  }
  grid
}


///|
pub fn voxel_occupied(grid : VoxelGrid, p : @core.Point3D) -> Bool {
  let idx = voxel_index(grid, p)
  if idx < 0 {
    return false
  }
  grid.data[idx]
}
