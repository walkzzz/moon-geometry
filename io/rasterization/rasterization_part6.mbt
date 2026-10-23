///|
/// Rasterize a line using Bresenham's algorithm.
/// 用 Bresenham 算法光栅化线段。
pub fn raster_line(
  buf : RasterBuffer,
  x0 : Int,
  y0 : Int,
  x1 : Int,
  y1 : Int,
  color : Int,
) -> Unit {
  let mut dx = x1 - x0
  let dy = y1 - y0
  let mut sx = 1
  if dx < 0 {
    dx = -dx
    sx = -1
  }
  let mut sy = 1
  let mut dy_abs = dy
  if dy < 0 {
    dy_abs = -dy
    sy = -1
  }
  let mut err = dx - dy_abs
  let mut x = x0
  let mut y = y0
  while true {
    set_pixel(buf, x, y, color)
    if x == x1 && y == y1 {
      return
    }
    let e2 = 2 * err
    if e2 > -dy_abs {
      err -= dy_abs
      x += sx
    }
    if e2 < dx {
      err += dx
      y += sy
    }
  }
}
