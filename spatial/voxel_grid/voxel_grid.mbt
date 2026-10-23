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
  nx : Int32
  ny : Int32
  nz : Int32
  data : Array[Bool]
}

///|
pub fn VoxelGrid::new(
  origin : @core.Point3D,
  voxel_size : Double,
  nx : Int32,
  ny : Int32,
  nz : Int32,
) -> VoxelGrid {
  { origin, voxel_size, nx, ny, nz, data: Array::make(nx * ny * nz, false), }
}
