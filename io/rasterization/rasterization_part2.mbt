///|
/// Set a pixel (no depth test). / 设置像素（无深度测试）。
pub fn set_pixel(
  buf : RasterBuffer,
  x : Int32,
  y : Int32,
  color : Int32,
) -> Unit {
  if x < 0 || x >= buf.width || y < 0 || y >= buf.height {
    return
  }
  buf.color[y * buf.width + x] = color
}
