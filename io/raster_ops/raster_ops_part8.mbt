///|
/// Raster algebra: element-wise multiply. / 栅格代数：逐元素乘。
pub fn raster_multiply(r1 : Raster, r2 : Raster) -> Raster {
  raster_binary_op(r1, r2, fn(a, b) { a * b })
}


///|
/// Apply scalar to all cells (add constant). / 所有像元加常量。
pub fn raster_add_scalar(r : Raster, c : Double) -> Raster {
  let result = Raster::new(r.cols, r.rows, 0.0, r.nodata)
  for i in 0..<r.data.length() {
    result.data[i] = r.data[i] + c
  }
  result
}
