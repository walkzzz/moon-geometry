///|
/// Rasterization buffer with color and depth.
/// 光栅化缓冲区（颜色 + 深度）。
pub struct RasterBuffer {
  width : Int
  height : Int
  color : Array[Int]
  depth : Array[Double]
}

///|
/// Create a raster buffer filled with background color and max depth.
/// 创建光栅缓冲区，填充背景色与最大深度。
pub fn RasterBuffer::new(width : Int, height : Int) -> RasterBuffer {
  let n = width * height
  { width, height, color: Array::make(n, 0), depth: Array::make(n, 1000000.0) }
}

///|
/// Clear buffer to a color and depth value.
/// 清空缓冲区为指定颜色与深度。
pub fn clear_buffer(buf : RasterBuffer, color : Int, depth : Double) -> Unit {
  for i in 0..<buf.color.length() {
    buf.color[i] = color
    buf.depth[i] = depth
  }
}

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

///|
/// Get pixel color. / 获取像素颜色。
pub fn get_pixel(buf : RasterBuffer, x : Int, y : Int) -> Int {
  if x < 0 || x >= buf.width || y < 0 || y >= buf.height {
    return 0
  }
  buf.color[y * buf.width + x]
}

///|
/// Get pixel depth. / 获取像素深度。
pub fn get_depth(buf : RasterBuffer, x : Int, y : Int) -> Double {
  if x < 0 || x >= buf.width || y < 0 || y >= buf.height {
    return 1000000.0
  }
  buf.depth[y * buf.width + x]
}

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

///|
/// Rasterize a triangle with depth interpolation.
/// 光栅化三角形（带深度插值）。
pub fn raster_triangle(
  buf : RasterBuffer,
  v0 : @core.Point3D,
  v1 : @core.Point3D,
  v2 : @core.Point3D,
  color : Int,
) -> Unit {
  let eps = 0.0000001
  let min_x = max3(min3(v0.x, v1.x), min3(v1.x, v2.x)) - 1.0
  let max_x = min3(max3(v0.x, v1.x), max3(v1.x, v2.x)) + 1.0
  let min_y = max3(min3(v0.y, v1.y), min3(v1.y, v2.y)) - 1.0
  let max_y = min3(max3(v0.y, v1.y), max3(v1.y, v2.y)) + 1.0
  let ix0 = max2(0, floor_int(min_x))
  let ix1 = min2(buf.width - 1, ceil_int(max_x))
  let iy0 = max2(0, floor_int(min_y))
  let iy1 = min2(buf.height - 1, ceil_int(max_y))
  let area = (v1.x - v0.x) * (v2.y - v0.y) - (v2.x - v0.x) * (v1.y - v0.y)
  if area > -eps && area < eps {
    return
  }
  for y in iy0..<=iy1 {
    for x in ix0..<=ix1 {
      let px = x.to_double()
      let py = y.to_double()
      let w0 = ((v1.x - px) * (v2.y - py) - (v2.x - px) * (v1.y - py)) / area
      let w1 = ((v2.x - px) * (v0.y - py) - (v0.x - px) * (v2.y - py)) / area
      let w2 = 1.0 - w0 - w1
      if w0 >= -eps && w1 >= -eps && w2 >= -eps {
        let z = w0 * v0.z + w1 * v1.z + w2 * v2.z
        set_pixel_depth(buf, x, y, color, z)
      }
    }
  }
}

///|
/// Count non-background pixels. / 统计非背景像素数。
pub fn count_filled(buf : RasterBuffer, bg : Int) -> Int {
  let mut count = 0
  for c in buf.color {
    if c != bg {
      count += 1
    }
  }
  count
}

fn min3(a : Double, b : Double) -> Double {
  if a < b {
    a
  } else {
    b
  }
}

fn max3(a : Double, b : Double) -> Double {
  if a > b {
    a
  } else {
    b
  }
}

fn min2(a : Int, b : Int) -> Int {
  if a < b {
    a
  } else {
    b
  }
}

fn max2(a : Int, b : Int) -> Int {
  if a > b {
    a
  } else {
    b
  }
}

fn floor_int(x : Double) -> Int {
  let f = @math.floor(x)
  f.to_int()
}

fn ceil_int(x : Double) -> Int {
  let f = @math.ceil(x)
  f.to_int()
}