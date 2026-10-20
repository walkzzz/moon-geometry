///|
/// # Voxel Grid
/// # 体素网格
///
/// Voxel grid for 3D spatial hashing and occupancy tracking.
/// 体素网格用于3D空间哈希和占用追踪。

///|
pub struct VoxelGrid {
  origin : @core.Point3D
  voxel_size : Double
  nx : Int
  ny : Int
  nz : Int
  data : Array[Bool]
}

///|
pub fn VoxelGrid::new(origin : @core.Point3D, voxel_size : Double, nx : Int, ny : Int, nz : Int) -> VoxelGrid {
  { origin, voxel_size, nx, ny, nz, data: Array::make(nx * ny * nz, false) }
}

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
