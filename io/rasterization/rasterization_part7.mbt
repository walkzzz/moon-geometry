///|
/// Rasterize a triangle with depth interpolation.
/// 光栅化三角形（带深度插值）。
pub fn raster_triangle(
  buf : RasterBuffer,
  v0 : @core.Point3D,
  v1 : @core.Point3D,
  v2 : @core.Point3D,
  color : Int32,
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
