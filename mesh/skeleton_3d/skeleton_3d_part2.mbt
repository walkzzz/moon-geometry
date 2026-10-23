///|
/// Check if coordinates are in bounds. / 检查坐标是否越界。
fn in_bounds(
  x : Int32,
  y : Int32,
  z : Int32,
  nx : Int32,
  ny : Int32,
  nz : Int32,
) -> Bool {
  x >= 0 && x < nx && y >= 0 && y < ny && z >= 0 && z < nz
}
