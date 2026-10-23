///|
pub fn voxel_index(grid : VoxelGrid, p : @core.Point3D) -> Int {
  let ix = ((p.x - grid.origin.x) / grid.voxel_size).floor().to_int()
  let iy = ((p.y - grid.origin.y) / grid.voxel_size).floor().to_int()
  let iz = ((p.z - grid.origin.z) / grid.voxel_size).floor().to_int()
  if ix < 0 || ix >= grid.nx || iy < 0 || iy >= grid.ny || iz < 0 || iz >= grid.nz {
    return -1
  }
  ix * grid.ny * grid.nz + iy * grid.nz + iz
}
