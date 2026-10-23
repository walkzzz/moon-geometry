///|
/// Rasterization buffer with color and depth.
/// 光栅化缓冲区（颜色 + 深度）。
pub struct RasterBuffer {
  width : Int32
  height : Int32
  color : Array[Int32]
  depth : Array[Double]
}

///|
/// Create a raster buffer filled with background color and max depth.
/// 创建光栅缓冲区，填充背景色与最大深度。
pub fn RasterBuffer::new(width : Int32, height : Int32) -> RasterBuffer {
  let n = width * height
  { width, height, color: Array::make(n, 0), depth: Array::make(n, 1000000.0), }
}

///|
/// Clear buffer to a color and depth value.
/// 清空缓冲区为指定颜色与深度。
pub fn clear_buffer(buf : RasterBuffer, color : Int32, depth : Double) -> Unit {
  for i in 0..<buf.color.length() {
    buf.color[i] = color
    buf.depth[i] = depth
  }
}
