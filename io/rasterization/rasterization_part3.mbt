///|
/// Set a pixel with depth test. / 设置像素（带深度测试）。
pub fn set_pixel_depth(
  buf : RasterBuffer,
  x : Int,
  y : Int,
  color : Int,
  depth : Double,
) -> Unit {
  if x < 0 || x >= buf.width || y < 0 || y >= buf.height {
    return
  }
  let idx = y * buf.width + x
  if depth < buf.depth[idx] {
    buf.color[idx] = color
    buf.depth[idx] = depth
  }
}
