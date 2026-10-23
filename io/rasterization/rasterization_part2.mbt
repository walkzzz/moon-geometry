///|
/// Set a pixel (no depth test). / 设置像素（无深度测试）。
pub fn set_pixel(
  buf : RasterBuffer,
  x : Int,
  y : Int,
  color : Int,
) -> Unit {
  if x < 0 || x >= buf.width || y < 0 || y >= buf.height {
    return
  }
  buf.color[y * buf.width + x] = color
}
