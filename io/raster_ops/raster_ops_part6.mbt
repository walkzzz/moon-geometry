///|
/// Mosaic two rasters (b overrides a where b is not nodata). / 镶嵌两个栅格（b 非 nodata 处覆盖 a）。
pub fn mosaic(r1 : Raster, r2 : Raster) -> Raster {
  let cols = if r1.cols > r2.cols { r1.cols } else { r2.cols }
  let rows = if r1.rows > r2.rows { r1.rows } else { r2.rows }
  let result = Raster::new(cols, rows, r1.nodata, r1.nodata)
  for row in 0..<rows {
    for col in 0..<cols {
      let v1 = r1.get(col, row)
      let v2 = r2.get(col, row)
      if v2 != r2.nodata {
        result.set(col, row, v2)
      } else {
        result.set(col, row, v1)
      }
    }
  }
  result
}
