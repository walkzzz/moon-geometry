///|
/// Volume data: dimensions, spacing, and scalar values. / 体数据：维度、间距和标量值。
pub struct VolumeData {
  dims : (Int32, Int32, Int32)
  spacing : (Double, Double, Double)
  data : Array[Double]
}

///|
/// Construct a volume filled with zeros. / 构造全零体数据。
pub fn VolumeData::new(
  dims : (Int32, Int32, Int32),
  spacing : (Double, Double, Double),
) -> VolumeData {
  let (nx, ny, nz) = dims
  let size = nx * ny * nz
  { dims, spacing, data: Array::make(size, 0.0), }
}

///|
/// Get value at (x, y, z). / 获取 (x, y, z) 处的值。
pub fn VolumeData::get(
  self : VolumeData,
  x : Int32,
  y : Int32,
  z : Int32,
) -> Double {
  let (nx, ny, _) = self.dims
  let idx = x + y * nx + z * nx * ny
  self.data[idx]
}

///|
/// Set value at (x, y, z). / 设置 (x, y, z) 处的值。
pub fn VolumeData::set(
  self : VolumeData,
  x : Int32,
  y : Int32,
  z : Int32,
  val : Double,
) -> Unit {
  let (nx, ny, _) = self.dims
  let idx = x + y * nx + z * nx * ny
  self.data[idx] = val
}

///|
/// Write volume as VTK ASCII structured points. / 将体数据写为 VTK ASCII 结构化点格式。
pub fn write_vtk_ascii(vol : VolumeData) -> String {
  let (nx, ny, nz) = vol.dims
  let (sx, sy, sz) = vol.spacing
  let mut out = "# vtk DataFile Version 3.0\n"
  out += "moon-geometry volume\n"
  out += "ASCII\n"
  out += "DATASET STRUCTURED_POINTS\n"
  out += "DIMENSIONS " +
    nx.to_string() +
    " " +
    ny.to_string() +
    " " +
    nz.to_string() +
    "\n"
  out += "SPACING " +
    sx.to_string() +
    " " +
    sy.to_string() +
    " " +
    sz.to_string() +
    "\n"
  out += "POINT_DATA " + vol.data.length().to_string() + "\n"
  out += "SCALARS values double 1\n"
  out += "LOOKUP_TABLE default\n"
  for v in vol.data {
    out += v.to_string() + "\n"
  }
  out
}
