///|
/// Get value at (col, row). Returns nodata if out of bounds. / 获取 (col, row) 处的值。越界返回 nodata。
pub fn Raster::get(r : Raster, col : Int, row : Int) -> Double {
  if col < 0 || col >= r.cols || row < 0 || row >= r.rows {
    return r.nodata
  }
  r.data[row * r.cols + col]
}
