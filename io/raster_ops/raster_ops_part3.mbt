///|
/// Set value at (col, row). Does nothing if out of bounds. / 设置 (col, row) 处的值。越界不做任何操作。
pub fn Raster::set(r : Raster, col : Int32, row : Int32, val : Double) -> Unit {
  if col < 0 || col >= r.cols || row < 0 || row >= r.rows {
    return
  }
  r.data[row * r.cols + col] = val
}

///|
/// Number of columns. / 列数。
pub fn Raster::cols(r : Raster) -> Int32 {
  r.cols
}
