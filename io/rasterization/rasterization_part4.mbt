///|
/// Get pixel color. / 获取像素颜色。
pub fn get_pixel(buf : RasterBuffer, x : Int, y : Int) -> Int {
  if x < 0 || x >= buf.width || y < 0 || y >= buf.height {
    return 0
  }
  buf.color[y * buf.width + x]
}
