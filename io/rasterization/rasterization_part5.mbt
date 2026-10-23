///|
/// Get pixel depth. / 获取像素深度。
pub fn get_depth(buf : RasterBuffer, x : Int32, y : Int32) -> Double {
  if x < 0 || x >= buf.width || y < 0 || y >= buf.height {
    return 1000000.0
  }
  buf.depth[y * buf.width + x]
}
