///|
/// Raster grid: rows x cols of double values. / 栅格网格：rows x cols 的双精度值。
pub struct Raster {
  cols : Int
  rows : Int
  data : Array[Double]
  nodata : Double
}

///|
/// Construct a raster filled with a value. / 用指定值填充构造栅格。
pub fn Raster::new(cols : Int, rows : Int, fill : Double, nodata : Double) -> Raster {
  let n = cols * rows
  let data = Array::make(n, fill)
  { cols, rows, data, nodata }
}

///|
/// Construct a raster from raw data. / 从原始数据构造栅格。
pub fn Raster::from_data(
  cols : Int,
  rows : Int,
  data : Array[Double],
  nodata : Double,
) -> Raster {
  { cols, rows, data, nodata }
}

///|
/// Get value at (col, row). Returns nodata if out of bounds. / 获取 (col, row) 处的值。越界返回 nodata。
pub fn Raster::get(r : Raster, col : Int, row : Int) -> Double {
  if col < 0 || col >= r.cols || row < 0 || row >= r.rows {
    return r.nodata
  }
  r.data[row * r.cols + col]
}

///|
/// Set value at (col, row). Does nothing if out of bounds. / 设置 (col, row) 处的值。越界不做任何操作。
pub fn Raster::set(r : Raster, col : Int, row : Int, val : Double) -> Unit {
  if col < 0 || col >= r.cols || row < 0 || row >= r.rows {
    return
  }
  r.data[row * r.cols + col] = val
}

///|
/// Number of columns. / 列数。
pub fn Raster::cols(r : Raster) -> Int {
  r.cols
}

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

///|
/// Min value in raster (ignoring nodata). / 栅格最小值（忽略 nodata）。
pub fn raster_min(r : Raster) -> Double {
  let mut min_val = 0.0
  let mut found = false
  for v in r.data {
    if v != r.nodata {
      if !found {
        min_val = v
        found = true
      } else if v < min_val {
        min_val = v
      }
    }
  }
  if found {
    min_val
  } else {
    r.nodata
  }
}

///|
/// Max value in raster (ignoring nodata). / 栅格最大值（忽略 nodata）。
pub fn raster_max(r : Raster) -> Double {
  let mut max_val = 0.0
  let mut found = false
  for v in r.data {
    if v != r.nodata {
      if !found {
        max_val = v
        found = true
      } else if v > max_val {
        max_val = v
      }
    }
  }
  if found {
    max_val
  } else {
    r.nodata
  }
}