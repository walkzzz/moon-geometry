///|
/// Apply a binary operation element-wise to two rasters. / 对两个栅格逐元素应用二元操作。
fn raster_binary_op(r1 : Raster, r2 : Raster, op : (Double, Double) -> Double) -> Raster {
  let cols = if r1.cols < r2.cols { r1.cols } else { r2.cols }
  let rows = if r1.rows < r2.rows { r1.rows } else { r2.rows }
  let result = Raster::new(cols, rows, 0.0, r1.nodata)
  for row in 0..<rows {
    for col in 0..<cols {
      result.set(col, row, op(r1.get(col, row), r2.get(col, row)))
    }
  }
  result
}


///|
/// Raster algebra: element-wise add. / 栅格代数：逐元素加。
pub fn raster_add(r1 : Raster, r2 : Raster) -> Raster {
  raster_binary_op(r1, r2, fn(a, b) { a + b })
}


///|
/// Raster algebra: element-wise subtract. / 栅格代数：逐元素减。
pub fn raster_subtract(r1 : Raster, r2 : Raster) -> Raster {
  raster_binary_op(r1, r2, fn(a, b) { a - b })
}
