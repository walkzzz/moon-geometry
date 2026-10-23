///|
/// Number of rows. / 行数。
pub fn Raster::rows(r : Raster) -> Int {
  r.rows
}


///|
/// Nearest-neighbor resampling to target size. / 最近邻重采样到目标尺寸。
pub fn resample_nearest(r : Raster, new_cols : Int, new_rows : Int) -> Raster {
  let result = Raster::new(new_cols, new_rows, r.nodata, r.nodata)
  for row in 0..<new_rows {
    for col in 0..<new_cols {
      let src_col = (col.to_double() * r.cols.to_double() / new_cols.to_double()).floor().to_int()
      let src_row = (row.to_double() * r.rows.to_double() / new_rows.to_double()).floor().to_int()
      let sc = if src_col >= r.cols { r.cols - 1 } else { src_col }
      let sr = if src_row >= r.rows { r.rows - 1 } else { src_row }
      result.set(col, row, r.get(sc, sr))
    }
  }
  result
}
