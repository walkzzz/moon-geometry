///|
/// Check if coordinates are in bounds. / 检查坐标是否越界。
fn in_bounds(
  x : Int,
  y : Int,
  z : Int,
  nx : Int,
  ny : Int,
  nz : Int,
) -> Bool {
  x >= 0 && x < nx && y >= 0 && y < ny && z >= 0 && z < nz
}
