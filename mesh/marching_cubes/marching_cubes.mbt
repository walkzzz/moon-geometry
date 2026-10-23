///|
/// Voxel grid for marching cubes. / Marching Cubes 体素网格。
pub struct McGrid {
  values : Array[Double]
  nx : Int32
  ny : Int32
  nz : Int32
}

///|
/// Construct a voxel grid. / 构造体素网格。
pub fn McGrid::new(
  values : Array[Double],
  nx : Int32,
  ny : Int32,
  nz : Int32,
) -> McGrid {
  { values, nx, ny, nz, }
}

///|
/// Get value at (i, j, k). / 获取 (i, j, k) 处的值。
pub fn McGrid::get(g : McGrid, i : Int32, j : Int32, k : Int32) -> Double {
  g.values[i + g.nx * (j + g.ny * k)]
}
