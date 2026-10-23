///|
/// Bilinear resampling to target size. / 双线性重采样到目标尺寸。
pub fn resample_bilinear(r : Raster, new_cols : Int, new_rows : Int) -> Raster {
  let result = Raster::new(new_cols, new_rows, r.nodata, r.nodata)
  for row in 0..<new_rows {
    for col in 0..<new_cols {
      let fx = col.to_double() * (r.cols - 1).to_double() / (new_cols - 1).to_double()
      let fy = row.to_double() * (r.rows - 1).to_double() / (new_rows - 1).to_double()
      let ix = fx.floor().to_int()
      let iy = fy.floor().to_int()
      let dx = fx - ix.to_double()
      let dy = fy - iy.to_double()
      let ix1 = if ix + 1 >= r.cols { ix } else { ix + 1 }
      let iy1 = if iy + 1 >= r.rows { iy } else { iy + 1 }
      let v00 = r.get(ix, iy)
      let v10 = r.get(ix1, iy)
      let v01 = r.get(ix, iy1)
      let v11 = r.get(ix1, iy1)
      let val = v00 * (1.0 - dx) * (1.0 - dy) +
        v10 * dx * (1.0 - dy) +
        v01 * (1.0 - dx) * dy +
        v11 * dx * dy
      result.set(col, row, val)
    }
  }
  result
}
